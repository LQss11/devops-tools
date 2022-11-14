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
vault secrets enable -version=2 -path=mykv kv
```
