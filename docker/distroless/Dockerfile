# Use the OpenJDK image to build the Java application
FROM openjdk:8-slim AS builder
WORKDIR /usr/src/app
COPY Hello.java .
RUN javac Hello.java

# Use the distroless image to run the Java application
FROM ubuntu/jre:8-22.04_edge
WORKDIR /usr/src/app
COPY --from=builder --chown=app /usr/src/app/Hello.class .
USER app
VOLUME ["/usr/src/app"]
# Set the entrypoint to directly run the Java class
ENTRYPOINT ["java", "Hello"]
