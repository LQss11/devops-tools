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
