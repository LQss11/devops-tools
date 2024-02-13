api_addr = "https://vault-production:8200"
cluster_addr = "https://192.168.1.222:8201"
cluster_name = "vault-spark-local-cluster"

max_lease_ttl = "10h"
default_lease_ttl = "10h"

log_level = "INFO"
disable_mlock = true
ui = true


storage "raft" {
  path    = "/opt/vault/data"
  node_id = "vault-1"
  // retry_join {
  //   leader_api_addr = "http://192.168.1.222:8200"
  // }
  // retry_join {
  //   leader_api_addr = "http://node-3:8200"
  // }  
}
listener "tcp" {
  address = "0.0.0.0:8200"
  cluster_address = "192.168.1.222:8201"
  tls_disable = false
  tls_disable_client_certs = true
  tls_cert_file = "/etc/vault/ssl/vault.crt"
  tls_key_file  = "/etc/vault/ssl/vault.key"  
}


telemetry {
  disable_hostname = true
  prometheus_retention_time = "12h"
}