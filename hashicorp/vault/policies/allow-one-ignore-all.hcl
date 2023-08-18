path "secret/*"
{
  capabilities = ["list"]
}

path "secret/metadata/+/*" {
  capabilities = ["deny"]
}

path "secret/metadata/app/*" {
  capabilities = ["list"]
}

path "secret/data/app/+/*"
{
  capabilities = ["read"]
}
