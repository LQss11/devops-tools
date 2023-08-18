path "secret/*"
{
  capabilities = ["list"]
}

path "secret/metadata/app1/*" {
  capabilities = ["deny"]
}

path "secret/data/app1/*" {
  capabilities = ["deny"]
}

path "secret/data/+/+/dev"
{
  capabilities = ["read"]
}

path "secret/data/app2/+/test"
{
  capabilities = ["read"]
}

