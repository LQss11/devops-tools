disable_mlock = true
ui            = true
max_lease_ttl = "10h"
default_lease_ttl = "10h"
api_addr = "http://0.0.0.0:8200"

listener "tcp" {
  address       = "0.0.0.0:8200"
  tls_disable = 1
}

storage "file" {
  path = "/vault/data"
}

telemetry {
  disable_hostname = true
  prometheus_retention_time = "12h"
}