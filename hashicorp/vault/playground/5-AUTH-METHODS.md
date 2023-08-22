# Vault authentication configurations
This will help us understand configuring authentication methods for our hashicorp Vault instance.

# Getting started
You can run the following command to enable an authentication method:
```sh
# Enable a method with a path
vault auth enable -path="cicd" -description="cicd approle apps" approle
# Disable a method with a path
vault auth disable cicd
```

You can also run this to configure the auth path
```sh
vault write auth/cicd/role/gitlab \
    secret_id_ttl=10m \
    token_num_uses=10 \
    token_ttl=20m \
    token_max_ttl=30m \
    secret_id_num_uses=40 \
    policies=test
```

also we can tune after creation:
```sh
vault auth enable userpass
vault auth tune -default-lease-ttl=24h userpass/
vault write auth/userpass/users/test password=mypass policies=test
vault list auth/userpass/users
vault read auth/userpass/users/test
```