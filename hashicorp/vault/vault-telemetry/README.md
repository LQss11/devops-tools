## Getting Started

- enable telemetry logging in the hcl config:
```sh
telemetry {
  disable_hostname = true
  prometheus_retention_time = "12h"
}
```
- Include prometheus vault token
```sh
echo "YOUR_PROMETHEUS_TOKEN"> prometheus/prometheus-token
```
- add **GRAFANA_ADMIN_PASSWORD** to environment variable using .env:
```sh
echo "GRAFANA_ADMIN_PASSWORD=yourpassword123"> .env
```
- Update vault server if added telemetry config and unseal it
```sh
docker-compose up -d
```
- Start services:
```sh
docker-compose -f ./docker-compose-monitoring.yaml up -d
```