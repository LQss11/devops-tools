# Secret Engines
## KV
```sh
vault secrets enable kv-v2
vault kv put kv/app/db pass=123 user=admin
vault kv get kv/app/db
vault kv put kv/app/db @secrets.json
```
## AWS
```sh
vault secrets enable aws
vault write aws/config/root access_key=<AWS Access key> secret_key=<AWS Secret key> region=us-east-1
vault read aws/creds/data-consultant
```
## Database
```sh
vault secrets enable database
vault write database/config/prod-database plugin_name=mysql-aurora-database-plugin connection_url="{{username}}:{{password}}@tcp(prod.cluster.us-east-1.amazonaws.com:3306)/" allowed_roles="app-integration, app-lambda" username="vault-admin" password="admin password"
vault read database/creds/oracle-reporting
```