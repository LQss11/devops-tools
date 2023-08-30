# Docker monitoring
# Getting started
Run docker compose:
```sh
docker-compose up --build -d
docker-compose -f docker-compose-node-exporter.yaml up -d
docker-compose -f docker-compose-cadvisor.yaml up -d
```
## Dashboards id
- Node exporter full: 1860
- Docker Container & Host Metrics : 10619

# TODO
- [] blackbox_exporter