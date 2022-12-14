# Azure 

## Az login
* Create file **variables.auto.tfvars**:
```sh
# Create sp
az ad sp create-for-rbac --name mysp
# Login with sp to have access for plan and apply
az login --service-principal --username "00000000-0000-0000-0000-000000000000" --password "00000000-0000-0000-0000-000000000000-" --tenant "00000000-0000-0000-0000-000000000000"
```
## Using hardcoded vars
```variables.auto.tfvars
subscription_id="00000000-0000-0000-0000-000000000000"
client_id="00000000-0000-0000-0000-000000000000"
tenant_id="00000000-0000-0000-0000-000000000000"
client_secret="00000000-0000-0000-0000-000000000000"
```

## Pass env vars

```
export ARM_CLIENT_ID="00000000-0000-0000-0000-000000000000"
export ARM_CLIENT_SECRET="00000000-0000-0000-0000-000000000000"
export ARM_SUBSCRIPTION_ID="00000000-0000-0000-0000-000000000000"
export ARM_TENANT_ID="00000000-0000-0000-0000-000000000000"
```