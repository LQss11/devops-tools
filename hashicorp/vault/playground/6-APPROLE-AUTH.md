# Vault Approle example
This is how to create an approle for machine to machine authentication
```sh
vault auth enable approle
vault write auth/approle/role/gitlab-ci policies=admin token_ttl=20m
# Get info
vault list auth/approle/role
# Role id is always the same
vault read auth/approle/role/gitlab-ci/role-id
# Role secret is new everytime
vault write -force auth/approle/role/gitlab-ci/secret-id
vault write auth/approle/role/login role_id=<the role id> secre_id=<the secret id>

# Update the policy of the approle
vault write auth/approle/role/gitlab-ci policies=test token_ttl=20m
```

then You can login using the specified values like this
```sh
export VAULT_ROLE_ID="YOUR_APPROLE_ROLE_ID"
export VAULT_SECRET_ID="YOUR_GENERATED_SECRET_ID"
VAULT_TOKEN=$(vault write -field=token auth/approle/login role_id=$VAULT_ROLE_ID secret_id=$VAULT_SECRET_ID)
```