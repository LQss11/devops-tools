storage_source "file" {
  path = "/vault/data"
}

storage_destination "raft" {
  path    = "/opt/vault/data"
  node_id = "node-1"
}

cluster_addr = "http://vault-production:8201"
