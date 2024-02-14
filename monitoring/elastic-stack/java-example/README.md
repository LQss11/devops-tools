# Enable apm on an tomcat/java/springboot
There are several ways to enable apm on a spring boot application, one of them is as the following steps:

**pom.xml**
```xml
<dependency>
    <groupId>co.elastic.apm</groupId>
    <artifactId>apm-agent-attach</artifactId>
    <version>${elastic-apm.version}</version>
</dependency>
```
**application.properties**
```conf
# Catalina props
CATALINA_OPTS=-javaagent:/usr/local/tomcat/apm-agent.jar -Delastic.apm.enabled=true -Delastic.apm.service_name=my-app -Delastic.apm.server_urls=http://host.docker.internal:8200 -Delastic.apm.application_packages=org.example,org.another.example -Delastic.apm.environment=test
```

**Dockerfile**
```Dockerfile
FROM tomcat:9-jre8
# Setup agent file
COPY --from=docker.elastic.co/observability/apm-agent-java:1.19.0 /usr/agent/elastic-apm-agent.jar /usr/local/tomcat/apm-agent.jar
```


- Find more in the [official documentation.](https://www.elastic.co/guide/en/apm/agent/java/master/setup-javaagent.html)
- [Elastic apm maven package](https://mvnrepository.com/artifact/co.elastic.apm/apm-agent-api)
- [Elastic apm java agent docker image ](https://container-library.elastic.co/r/observability/apm-agent-java)
- [Config docs](https://www.elastic.co/guide/en/apm/agent/java/master/configuration.html)