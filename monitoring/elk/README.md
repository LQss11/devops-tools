# ELK monitoring
Setup ELK stack with required configuration and integrations:
# Docker
In this example I created a directory where each application is configured and can be connected to other services using compose project name:
```sh
# SERVICES
## elasticsearch|kibana|logstash|apm
# Powershell
$env:SERVICE = "elasticsearch"
## Run
docker-compose -p monitoring --env-file monitoring/elk/.env -f monitoring/elk/$($env:SERVICE)/docker-compose.yaml up -d
## Remove
docker-compose -p monitoring --env-file monitoring/elk/.env -f monitoring/elk/$($env:SERVICE)/docker-compose.yaml rm -v -s -f
# Bash
export SERVICE="elasticsearch"
## Run
docker-compose -p monitoring --env-file monitoring/elk/.env -f monitoring/elk/${SERVICE}/docker-compose.yaml up
## Remove
docker-compose -p monitoring --env-file monitoring/elk/.env -f monitoring/elk/${SERVICE}/docker-compose.yaml rm -v -s -f

## Remove stack
# Powershell
docker-compose -p monitoring --env-file monitoring/elk/.env -f monitoring/elk/$($env:SERVICE)/docker-compose.yaml down --remove-orphans
# Bash
docker-compose -p monitoring --env-file monitoring/elk/.env -f monitoring/elk/${SERVICE}/docker-compose.yaml down --remove-orphans
```