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
```
## Dashboards id
- Node exporter full: 1860
- Docker Container & Host Metrics : 10619

# TODO
- [] blackbox_exporter