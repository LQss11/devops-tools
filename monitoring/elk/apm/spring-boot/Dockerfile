FROM tomcat:9-jre8
# Setup agent file
COPY --from=docker.elastic.co/observability/apm-agent-java:1.19.0 /usr/agent/elastic-apm-agent.jar /usr/local/tomcat/apm-agent.jar
ENV ELASTIC_APM_ENABLED=true
ENV ELASTIC_APM_SERVICE_NAME=my-cool-service
ENV ELASTIC_APM_APPLICATION_PACKAGES=org.example,org.another.example
ENV ELASTIC_APM_SERVER_URL=http://host.docker.internal:8200
ENV CATALINA_OPTS=-javaagent:/usr/local/tomcat/apm-agent.jar

# JAVA_OPTS='-javaagent:/app/elastic-apm-agent.jar  -Delastic.apm.service_name=aidbox 
# docker build -t java-agent-test .
# docker run -it --rm -p 8899:8080 java-agent-test