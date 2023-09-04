# Docker monitoring
# Getting started
Run docker compose:
```sh
docker-compose up --build -d
# Import node exporter to monitor node
docker-compose -f docker-compose-node-exporter.yaml up -d
# Import cadvisor to monitor container logs
docker-compose -f docker-compose-cadvisor.yaml up -d
# Import alert manager to monitor metrics alerts through rules
docker-compose -f docker-compose-alert-manager.yaml up -d
# Import nginx exporter to monitor a specific nginx server
# Make sure to include stub path to do this 
docker-compose -f docker-compose-nginx-exporter.yaml up -d
# collect http(s) and tls server info 
docker-compose -f docker-compose-blackbox-exporter.yaml up -d
```
## Dashboards id
- Node exporter full: 1860
- Docker Container & Host Metrics : 10619
- Nginx Exporter : 12708
- Prometheus Blackbox Exporter : 7587

# INFO
Generate htpasswd users
```sh
docker run --rm -ti xmartlabs/htpasswd root aaaa
docker run --rm httpd:alpine htpasswd -Bbn username password
```
# TODO
- [] blackbox_exporter
