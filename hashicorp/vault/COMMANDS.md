# Vault commands
! Make sure to export the following env vars
```sh
export VAULT_ADDR=https://localhost:8200
export VAULT_TOKEN=hvs.wSBFjI6EgElNl5CQdtqcTFoY
```
## API
curl -ks -H "X-Vault-Token: ${VAULT_TOKEN}" --request LIST ${VAULT_ADDR}/v1/auth/token/accessors | jq
## CMD
```sh
# Create secret
vault secrets enable -version=2 -path=mykv kv
# Get created secret kv
vault kv get -format=table secret/mykv 
# Create a key value pair 
vault kv put -mount=secret mykv bar=baz
# Get data from a kv
vault kv get -field bar -format=table secret/mykv
```

# Policies
```sh
vault policy write prometheus-metrics - << EOF
path "/sys/metrics" {
  capabilities = ["read"]
}
EOF
```
# Users
```sh
# Enable userpass authentication method
vault auth enable -path="userpass" userpass
# Define username, create user/entity/alias and assign policies and assign entity to alias
USER="test"
vault write auth/userpass/users/${USER} password="mystrongpass" policies="default"
vault write identity/entity name=${USER}
entity_id=$(vault read -format=json identity/entity/name/${USER} | jq -r '.data.id')
userpass_accessor=$(vault auth list -format=json | jq -r '.["userpass/"].accessor')
vault write identity/entity-alias name=${USER} canonical_id=${entity_id} mount_accessor=${userpass_accessor}
vault write identity/entity/id/${entity_id} policies="test"
# Login using the new identity
vault login -method=userpass -path=userpass username=${USER} password=mystrongpass
```
# Approle
```sh
vault write auth/approle/role/example-role \
    secret_id_ttl=0 \
    token_ttl=0 \
    token_policies=stark-b2b-dev-ro
# Get role id
VAULT_ROLE_ID=$(vault read -field=role_id auth/approle/role/example-role/role-id)
# Generate Secret ID (for GitLab pipeline)
VAULT_SECRET_ID=$(vault write -field=secret_id -f auth/approle/role/example-role/secret-id)
vault write -field=token auth/approle/login role_id=$VAULT_ROLE_ID secret_id=$VAULT_SECRET_ID
```
# Token
```sh
vault token create \
  -field=token \
  -policy prometheus-metrics \
  > $LEARN_VAULT/prometheus-config/prometheus-token

vault login
vault token lookup | grep policies

vault token create -policy="default" -no-default-policy -ttl=0
```