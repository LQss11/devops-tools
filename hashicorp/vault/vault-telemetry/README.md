# Monitoring
Monitoring is important to get an idea about what's happening in your vault environment, in order to do that we are using prometheus and grafana together to fetch data and show them in a dashboard.

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

You can import the [hashicorp vault dashboard](https://grafana.com/grafana/dashboards/12904-hashicorp-vault/) with id **12904**

Also to enable pie-chart plugin in grafana run the following:
```sh
docker-compose -f ./docker-compose-monitoring.yaml exec grafana bash -c "grafana cli plugins install grafana-piechart-panel"
# you must restart the instance to apply changes
docker-compose -f ./docker-compose-monitoring.yaml restart grafana
```