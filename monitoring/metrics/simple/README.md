# Monitoring Stack Setup with Docker Compose

This setup provides a monitoring stack using Docker Compose.
## Setup Overview

### Prerequisites

- Docker and Docker Compose installed on your machine.

### Services

1. **cAdvisor**: Monitors and collects metrics from Docker containers.
2. **Node Exporter**: Collects hardware and OS metrics from the host.
3. **Prometheus**: Scrapes metrics from cAdvisor, Node Exporter, and itself.
4. **Grafana**: Visualizes the metrics collected by Prometheus.

### How to Set Up

1. **Clone the Repository**: Ensure you have a directory structure as shown below:
   ```
   ├── docker-compose.yaml
   └── prometheus
       ├── docker-prometheus.yml
       └── scrape-configs
           ├── cadvisor.yml
           ├── node-exporter.yml
           └── prometheus.yml
   ```

2. **Configure Prometheus**:
   - `docker-prometheus.yml`: Defines global settings and alerting rules.
   - `scrape-configs/`: Contains scrape configurations for cAdvisor, Node Exporter, and Prometheus.

3. **Start the Services**:
   ```bash
   docker-compose up -d
   ```

### Accessing the Services

Here's the information in a table format:

| Service        | URL                                            |
| -------------- | ---------------------------------------------- |
| **cAdvisor**   | [http://localhost:8080](http://localhost:8080) |
| **Prometheus** | [http://localhost:9090](http://localhost:9090) |
| **Grafana**    | [http://localhost:3000](http://localhost:3000) |

#### **Grafana credentials:** `admin` `helloworld123`

### Configuration Files

- **docker-compose.yaml**: Defines the services and their configurations.
- **prometheus/docker-prometheus.yml**: Main configuration file for Prometheus.
- **scrape-configs/**: Contains individual scrape configurations for each service.

### Environment Variables

- **Grafana**:
  - `GF_SECURITY_ADMIN_USER`: Admin username (default: `admin`)
  - `GF_SECURITY_ADMIN_PASSWORD`: Admin password (default: `helloworld123`)

### Volumes

- `grafana-data`: Persists Grafana data.
- `prometheus-data`: Persists Prometheus data.

## Conclusion

This setup provides a robust monitoring solution for Docker environments. By using cAdvisor, Node Exporter, Prometheus, and Grafana, you can efficiently collect, store, and visualize metrics from your Docker containers and host system.