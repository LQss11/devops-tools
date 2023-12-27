provider "openstack" {
  #   user_name   = "admin"
  #   password    = "secret"
  tenant_name                   = "admin"
  auth_url                      = "http://xx.xxx.xx.xxx/identity"
  region                        = "RegionOne"
  insecure                      = true
  application_credential_name   = "test"
  application_credential_id     = "9ddcadf5ad2542d5aa69a462c5ab8212"
  application_credential_secret = "secret"
}

# export OS_AUTH_TYPE=v3applicationcredential
# export OS_AUTH_URL=http://xx.xxx.xx.xxx/identity
# export OS_IDENTITY_API_VERSION=3
# export OS_REGION_NAME="RegionOne"
# export OS_INTERFACE=public
# export OS_APPLICATION_CREDENTIAL_ID=9ddcadf5ad2542d5aa69a462c5ab8212
# export OS_APPLICATION_CREDENTIAL_SECRET=secret
