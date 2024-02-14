# Elastic Stack Documentation

This repository provides a Dockerized setup for the Elastic Stack, encompassing Elasticsearch, Kibana, and the Elastic APM (Application Performance Monitoring) server. The configuration is designed for efficient log, metric, and trace monitoring across various services and applications.

## Docker Compose Structure

### APM Server

The APM Server is configured via `apm/config/apm-server.yml` with specific Index Lifecycle Management (ILM) policies for different event types. These policies manage data retention and index rollovers effectively.

### Elasticsearch

Elasticsearch is configured in `elasticsearch/config/elasticsearch.yml`, setting up a single-node cluster with X-Pack security enabled for trial purposes and monitoring features.

### Kibana

Kibana's configuration is defined in `kibana/config/kibana.yml`, connecting to the Elasticsearch cluster. It enables X-Pack security and sets up the server on `0.0.0.0:5601`.

### Java Example

A sample Java application in the `java-example` directory uses the Elastic APM Java agent for application monitoring. Refer to `java-example/README.md` for integration instructions.

## Quick Start

- **Build and Start Services:**
```bash
make docker-init
```
Builds and starts all services defined in Docker Compose files.

- **Stop Services:**
```bash
make docker-stop <service>
```
Stops the specified service.

- **Clean Up:**
```bash
make docker-clean
```
Removes all Docker containers, networks, and volumes associated with the project.

## Monitoring Java Application

To test the APM setup with a Java application:

1. Build and run the Java example:
```bash
make docker-run java-example
```
2. Access the Java application's metrics endpoint:
```bash
while true; do curl -I localhost:8080/ && sleep 1; done
```
This will Continuously sends request information to the APM server.

## Additional Commands

- **Generate HTTPD User:**
```bash
make httpd
```
Creates an HTTPD user with a password.

- **Generate Password:**
```bash
make pwgen
```
Generates a password.

- **Generate dotenv Files:**
```bash
make dotenv
```
Generates dotenv files in all directories based on the global environment.

## Further Documentation

- [Index Lifecycle Management (ILM) Documentation](https://www.elastic.co/guide/en/elasticsearch/reference/7.10/ilm-index-lifecycle.html#ilm-phase-transitions)
- [Elastic APM Java Agent Documentation](https://www.elastic.co/guide/en/apm/agent/java/master/setup-javaagent.html)
- [Elastic APM Maven Package](https://mvnrepository.com/artifact/co.elastic.apm/apm-agent-api)
- [Elastic APM Java Agent Docker Image](https://container-library.elastic.co/r/observability/apm-agent-java)
- [Elastic APM Configuration Docs](https://www.elastic.co/guide/en/apm/agent/java/master/configuration.html)

Feel free to explore and customize the configurations based on your requirements.