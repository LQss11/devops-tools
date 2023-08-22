# Vault Approle example
This is how to create an approle for machine to machine authentication
```sh
vault auth enable approle
vault write auth/approle/role/gitlab-ci policies=admin token_ttl=20m
# Get info
vault list auth/approle/roles
# Role id is always the same
vault read auth/approle/role/gitlab-ci/role-id
# Role secret is new everytime
vault write -force auth/approle/role/gitlab-ci/secret-id
vault write auth/approle/role/login role_id=<the role id> secre_id=<the secret id>
```
