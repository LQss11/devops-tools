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

# To rename a secret engine
vault secrets move kv mysecretengine
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
    token_policies=admin,someotherpolicy
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

# aws
```sh
vault secrets enable aws
# Config vault for aws to manage useres
vault write aws/config/root \
access_key=<ACCESS_KEY> \
secret_key=<SECRET_KEY> \
region=us-east-1
# Read the config user info
vault read aws/config/root
# Rotate the root keys (in case you want ot regenrate a new root config)
vault write -f aws/config/rotate-root

## Manage Users
# Create user with type arn
vault write aws/roles/readonlyuser \
policy_arns=arn:aws:iam:aws:policy/ReadOnlyAccess \
credentials_type=iam_user
# Read user info
vault read aws/roles/readonlyuser

# Generate credentials
vault read aws/creds/readonlyuser
# Revoke single user
vault lease revoke aws/roles/readonlyuser/<lease_id>
# Revoke a set of users by prefix
vault lease revoke -prefix aws/roles/readonlyuser
```

# Database
```sh
vault secrets enable -path=mysql database
# Create mysql config example
# Follow this url https://developer.hashicorp.com/vault/docs/secrets/databases/mysql-maria
vault write mysql/config/mysql-database-dev \
plugin_name=mysql-rds-database-plugin \
connection_url="{{username}}:{{password}}@tcp(localhost:3306)/" \
allowed_roles="advanced" \
username="admin" \
password="mypassword"

# Create role
vault write database/roles/my-role \
    db_name=mysql-database-dev \
    creation_statements="CREATE USER '{{name}}'@'%' IDENTIFIED BY '{{password}}';GRANT SELECT ON *.* TO '{{name}}'@'%';" \
    default_ttl="1h" \
    max_ttl="24h"
# Get role info
vault read database/roles/my-role
# Edit role 
vault write database/roles/my-role revocation_statements="..."
# Create a new user in our mysql database
vault read mysql/creds/my-role
# Revoke leases
vault lease revoke -prefix mysql/creds/my-role
```

# pki
```sh
vault secrets enable pki
vault secrets tune -max-lease-ttl=87600h pki
vault write -field=certificate pki/root/generate/internal \
common_name="vaultadvanced.com" \
ttl=87600h > ca_cert.crt

vault write pki/config/urls \
issuing_certificates="https://127.0.0.1:8200/v1/pki/ca" \
crl_distribution_points="https://127.0.0.1:8200/v1/pki/crl"

vault secrets enable -path=pki_int -description="intermediate pki" pki
vault secrets list
vault secrets tune -max-lease-ttl=43800h pki_int
vault write -format=json pki_int/intermediate/generate/internal \
common_name="vaultadvanced.com Intermediate Authority" | jq -r '.data.csr' >pki_intermediate.csr

vault write -format=json pki/root/sign-intermediate csr=@pki_intermediate.csr \
format=pem_bundle ttl="43800h" | jq -r '.data.certificate' >intermediate.cert.pem

vault write pki_int/intermediate/set-signed certificate=@intermediate.cert.pem

vault write pki_int/roles/vaultadvanced \
allowed_domains="vaultadvanced.com" allow_subdomains=true max_ttl="720"
vault read pki_int/roles/vaultadvanced

vault write pki_int/issue/vaultadvanced common_name="learn.vault  advanced.com" ttl="24h"
```
