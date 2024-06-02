# syntax = docker/dockerfile:experimental
FROM maven:3.8.6-openjdk-11-slim AS build
WORKDIR /usr/src/app
COPY . .
RUN --mount=type=cache,target=/root/.m2 mvn clean install


FROM eclipse-temurin:11-alpine
WORKDIR /usr/src/app

# # Setup agent file
RUN apk add -q wget
RUN wget -O /opt/dd-java-agent.jar 'https://dtdg.co/latest-java-tracer' 

COPY --from=build /usr/src/app/target/hello-world-0.0.1.jar myapp.jar
ENTRYPOINT ["java" , "-javaagent:/opt/dd-java-agent.jar","-Ddd.logs.injection=true", "-Ddd.trace.sample.rate=1", "-jar" , "myapp.jar"]