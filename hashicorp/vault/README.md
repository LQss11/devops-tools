# hashicorp-vault
To login using token inside vault container you have to set the following env variables:
```sh
export VAULT_ADDR='http://localhost:8200'
export VAULT_TOKEN="token"
```

Create a new secret set
vault kv get -format=table env/db 

Add values to the secret

Get kv 
vault kv get -format=yaml -field=data env/db