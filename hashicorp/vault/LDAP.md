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
