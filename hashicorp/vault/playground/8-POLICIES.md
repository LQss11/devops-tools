# Vault Policies
```sh
# Create a policy in vault
vault policy write admin-policy /tmp/admin.hcl
```

# Capabilities
- create 
- update 
- read 
- delete 
- list 
- sudo
- deny

# Templated policies
You can check this [url](https://developer.hashicorp.com/vault/docs/concepts/policies#templated-policies) for more, here is an example for that

```sh
path "secret/data/{{identity.entity.id}}/*" {
  capabilities = ["create", "update", "patch", "read", "delete"]
}

path "secret/metadata/{{identity.entity.id}}/*" {
  capabilities = ["list"]
}
```
