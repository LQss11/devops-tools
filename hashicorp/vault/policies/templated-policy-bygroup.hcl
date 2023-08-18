path "users/data/{{identity.groups.ids.xxxxx-xxxx-xxxx-xxxx-xxxxxxxx.name}}/*" {
  capabilities = [ "create", "update", "read", "delete", "list", "sudo"]
}
path "users/metadata/{{identity.groups.ids.xxxxx-xxxx-xxxx-xxxx-xxxxxxxx.name}}/*" {
  capabilities = [ "create", "update", "read", "delete", "list", "sudo"]
}
path "users/*" {
  capabilities = [ "list"]
}