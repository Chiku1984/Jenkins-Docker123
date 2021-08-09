FROM tomcat:8.5.47-jdk8-openjdk
ADD . target/*.jar /usr/local/tomcat/webapps