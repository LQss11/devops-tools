storage "raft" {
  path    = "/opt/vault/data"
  node_id = "node-2"
  retry_join {
    leader_api_addr = "http://node-1:8200"
  }
  // retry_join {
  //   leader_api_addr = "http://node-3:8200"
  // }    
}
listener "tcp" {
 address = "0.0.0.0:8200"
 cluster_address = "node-2:8201"
 tls_disable = true
}
api_addr = "http://node-1:8200"
cluster_addr = "http://node-2:8201"
cluster_name = "vault-ha-cluster"
ui = true
log_level = "INFO"
disable_mlock = true