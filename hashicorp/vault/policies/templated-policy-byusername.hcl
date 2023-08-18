# Check the following url
# https://developer.hashicorp.com/vault/tutorials/policies/policy-templating#create-templated-acl-policies
path "users/data/{{identity.entity.aliases.auth_ldap_xxxxxx.name}}/*" {
  capabilities = [ "create", "update", "read", "delete", "list"]
}