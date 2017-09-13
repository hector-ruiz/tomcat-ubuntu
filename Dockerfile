FROM ubuntu:16.04

# Install dependencies
RUN apt-get clean && apt-get update -y && apt-get install -y locales curl nano vim wget git 
build-essential software-properties-common default-jdk

# Define commonly used JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/java-1.8.0-openjdk-amd64/jre

# Set locales
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_CTYPE en_US.UTF-8

# Download tomcat
RUN cd /tmp && curl -O 
http://apache.mirrors.ionfish.org/tomcat/tomcat-8/v8.5.20/bin/apache-tomcat-8.5.20.tar.gz

# Install tomcat
RUN mkdir /opt/tomcat && cd /tmp && tar xzvf apache-tomcat-8*tar.gz -C /opt/tomcat 
--strip-components=1
ENV CATALINA_PID /opt/tomcat/temp/tomcat.pid
ENV CATALINA_HOME /opt/tomcat
ENV CATALINA_BASE /opt/tomcat
ENV CATALINA_OPTS -Xms512M -Xmx1024M -server -XX:+UseParallelGC
ENV JAVA_OPTS -Djava.awt.headless=true -Djava.security.egd=file:/dev/./urandom

EXPOSE 8080 8443 8009
VOLUME /opt/tomcat/webapps
WORKDIR /opt/tomcat

CMD ["/opt/tomcat/bin/catalina.sh", "run"]


