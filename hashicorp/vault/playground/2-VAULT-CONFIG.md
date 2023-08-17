# Vault Config
The following is an example of how to configure a hashicorp instance

```sh
max_lease_ttl = "10h"
default_lease_ttl = "10h"

storage "raft" {
  path    = "/opt/vault/data"
  node_id = "vault-node-a"
}

listener "tcp" {
  address     = "0.0.0.0:8200"
  tls_disable = "true"
  cluster_address  = "0.0.0.0:8201"
  tls_disable_client_certs = true
  tls_cert_file = "/etc/vault/ssl/vault.crt"
  tls_key_file  = "/etc/vault/ssl/vault.key"  

}

seal "awskms" {
region     = "us-west-2"
kms_key_id = "xxxxx-xxxx-xxxx-xxxx-xxxxx"
}

cluster_addr = "https://vault-node-a.gswhv.com:8201"
cluster_name = "my-vault-cluster"
api_addr = "vault.gswhv.com:8200"
ui = true
disable_mlock = true
log_level = "ERROR"
```

You can verify the vault configuration by running the following command:
```sh
vault operator diagnose -config=/etc/vault.d/vault.hcl
```
You can simply apply updated configuration by restarting the service:
```sh
# systemctl
systemctl restart vault
# service
service vault restart
```