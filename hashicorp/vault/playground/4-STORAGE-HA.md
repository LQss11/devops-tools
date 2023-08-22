# Vault Storage
raft is one of the vault storage 
# Config
## Node1
```sh
storage "raft" {
  path    = "/opt/vault/data"
  node_id = "node-1"
}
listener "tcp" {
 address = "node-1:8200"
 cluster_address = "node-1:8201"
 tls_disable = true
}
api_addr = "http://vault-production:8200"
cluster_addr = "http://node-1:8201"
cluster_name = "vault-ha-cluster"
ui = true
log_level = "INFO"
disable_mlock = true
```

## Node2
```sh
storage "raft" {
  path    = "/opt/vault/data"
  node_id = "node-2"
}
listener "tcp" {
 address = "node-2:8200"
 cluster_address = "node-2:8201"
 tls_disable = true
}
api_addr = "http://vault-production:8200"
cluster_addr = "http://node-2:8201"
cluster_name = "vault-ha-cluster"
ui = true
log_level = "INFO"
disable_mlock = true
```
# Get cluster nodes
```sh
vault operator raft list-peers 
```
# Join to leader node
```sh
vault operator raft join http://node-1:8200
```
# Stop a node from being leader
Make the node stop being leader so other nodes will elect new leader
```sh
vault operator step-down
```