# hashicorp-vault
# Quick start
You can start a vault server using docker compose, to do so make sure to run:
```sh
docker-compose up
```

# Get vault cli
```sh
docker run -it -e VAULT_SKIP_VERIFY="1" -e VAULT_ADDR='http://localhost:8200' -e VAULT_TOKEN="token" --rm -v ${pwd}:/app -w /app --entrypoint="" vault:1.13.3 sh
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
vault kv get -format=table cubbyhole/somesecret 

Add values to the secret

Get kv 
vault kv get -format=yaml -field=mydatakey mykv/mysecret

# LDAP Configuration
```sh
# Enable LDAP authentication method
vault auth enable ldap

# Configure LDAP
export LDAP_URL=ldap://ldap
vault write auth/ldap/config \
  url="${LDAP_URL}" \
  binddn="cn=admin,dc=example,dc=myorg,dc=com" \
  bindpass="mypw" \
  userdn="ou=users,dc=example,dc=myorg,dc=com" \
  userattr="uid" \
  groupdn="ou=groups,dc=example,dc=myorg,dc=com" \
  groupattr="cn"

# Create secret group
vault kv put secret/devops-vault/database password=mypassword

# Create a policy
cat >devops-vault-policy.hcl <<EOF
path "secret/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}
EOF
vault policy write devops-vault-policy devops-vault-policy.hcl

# Add group
vault write auth/ldap/groups/devops policies=devops-vault-policy
# Add User "Groups and policies can be comma separated"
vault write auth/ldap/users/saffes groups=devops policies=devops-vault-policy
```

### Additional HElP
You can start the server manually by running vault server -dev
Links that might help
* [hashicorp vault on ubuntu](https://www.digitalocean.com/community/tutorials/how-to-securely-manage-secrets-with-hashicorp-vault-on-ubuntu-20-04)
* [start server manually](https://learn.hashicorp.com/tutorials/vault/getting-started-dev-server)
