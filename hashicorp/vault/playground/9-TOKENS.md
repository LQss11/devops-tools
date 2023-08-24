# Vault Policies
```sh
# Create token
vault token create -ttl=5m -use-limit=3 -policy=admin-policy
# Revoke token
vault token revoke -self
vault token revoke ${MY_TOKEN}
# Get info about token
vault token lookup ${MY_TOKEN}
# Get info about access on a specific path with a token
vault token capabilities ${MY_TOKEN} kv/data/apps/webapp
# Specify token type (batch type is not persisted and service is default type)
vault wrute auth/approle/role/myrole token_type=batch
```

# Token type 
there are different token types:
- service
- batch
- root
- periodic
- orphan
- cidr bound