# hashicorp-vault
# Quick start
You can start a vault server using docker compose, to do so make sure to run:
```sh
docker-compose up
```


# Info
The container has a Vault configuration directory set up at **/vault/config** and the server will load any **HCL** or **JSON** configuration files placed
You can find a set of great configs in this [repo](https://github.com/hashicorp/vault/tree/main/command/server/test-fixtures) and for more details you can check the official [vault documentation](https://www.vaultproject.io/docs/config/index.html).
# Manage kv
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

### Additional HElP
You can start the server manually by running vault server -dev
Links that might help
* [hashicorp vault on ubuntu](https://www.digitalocean.com/community/tutorials/how-to-securely-manage-secrets-with-hashicorp-vault-on-ubuntu-20-04)
* [start server manually](https://learn.hashicorp.com/tutorials/vault/getting-started-dev-server)