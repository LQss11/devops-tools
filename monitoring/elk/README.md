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


## Insert Data
You can insert data by running the following commands:
```sh
docker exec -it elasticsearch bash
# Insert Document data through file
curl -u "elastic:changeme" -XPOST -H "Content-Type: application/json" http://localhost:9200/myindex/mytype/1 -d@data.json
# Insert Document data Through query
curl -u "elastic:changeme" -XPOST -H "Content-Type: application/json" http://localhost:9200/myindex/mytype/1 -d '{
  "username": "user1",
  "gender": "male",
  "email": "user1@example.com"
}'
curl -u "elastic:changeme" -XPOST -H "Content-Type: application/json" http://localhost:9200/myindex/mytype/2 -d '{
  "username": "user2",
  "gender": "male",
  "email": "user2@example.com"
}'
#  Get Document
curl -u "elastic:changeme" -XGET http://localhost:9200/myindex/mytype/1
# Get all users where username
curl -u "elastic:changeme" -XGET -H "Content-Type: application/json" -d '{
    "query": {
        "exists": {
            "field": "fieldName"
        }
    }
}' http://localhost:9200/myindex/_search
# Update document
curl -u "elastic:changeme" -XPOST -H "Content-Type: application/json" -d '{
  "doc": {
    "field1": "new_value"
  }
}' http://localhost:9200/myindex/mytype/1/_update
# Delete document
curl -u "elastic:changeme" -XDELETE http://localhost:9200/myindex/mytype/1

```
