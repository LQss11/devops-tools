# Init seal unseal vault
```sh
vault status
# Generate unseal keys + root token
vault operator init
vault operator unseal
```
## Auto unseal
Instead of unsealing using a manual process we can use one of the cloud services that will unseal the vault for us. You can follow this [link](https://developer.hashicorp.com/vault/tutorials/auto-unseal) for more information.

To autounseal we need do the following:
- Stop the vault service (this will automatically seal the vault)
- Configure our auto unseal parameters
- Start the vault service 
- Run `vault operator unseal -migrate`
- make sure that you use the old unseal keys to enable auto unsealing

### Config
- Azure Key Vault:
```sh
seal "azurekeyvault" {
  client_id      = "YOUR-APP-ID"
  client_secret  = "YOUR-APP-PASSWORD"
  tenant_id      = "YOUR-AZURE-TENANT-ID"
  vault_name     = "Test-vault-XXXXXX"
  key_name       = "generated-key"
}
```
- AWS KMS:
```sh
seal "awskms" {
region     = "us-west-2"
kms_key_id = "df68263c-d9ee-44e3-afca-83cfa370c605"
}
# You will need to export the following params:
# AWS_ACCESS_KEY_ID='XXXXXXXXXXXXXXX'
# AWS_SECRET_ACCESS_KEY='XXXXXXXXXXXXXXX'
# AWS_REGION='us-east-1'
``` 
- Transit auto unseal
transit auto unseal allow us to auto unseal a vault cluster usgin another vault. so we have a vault dependant on another vault
```sh
seal "transit" {
  address = "http://127.0.0.1:8200"
  disable_renewal = "false"
  key_name = "autounseal"
  mount_path = "transit/"
  tls_skip_verify = "true"
}
```

#### Passing config env variables
Before enabling auto unseal for example for **aws** or **azure** we need a **vault.env** file right in the same dir as **vault.hcl** config containing the `aws access key, secret key` or `azure service principle` information...

