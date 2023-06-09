# AZURE BASIC COMMANDS
Login to az account: 
```sh
az login # Will open terminal
az login -u <username> -p <password> # plaintext
read -sp "Azure password: " AZ_PASS && echo && az login -u <username> -p $AZ_PASS # Bash
```
get signed in users: `az ad signed-in-user show`

get all locations:
```sh
az account list-locations --output table
```

- query someething `az ad signed-in-user show -o yaml --query otherMails`
- create resource group: `az group create --name mygroup --location "france"` 
- get current subscription been used: `az account list`
- get current rgs: `az group list -o table`
- list all resources in rg: `az resource list -g helmgroup`
- list azure providers: `az provider list -o table | awk  '{print $1}' | tail +3`
- get all resource ypes from a provider: `az provider list --query "[?namespace=='Microsoft.Compute'].[resourceTypes[*].resourceType]" -o yaml`
- delete resource `az resource delete --resource-group ExampleResourceGroup --name ExampleVM --resource-type "Microsoft.Compute/virtualMachines"`
- get all resource types: `az provider list -o table | awk  '{print $1}' | tail +3 | xargs -I {}  az provider list --query "[?namespace=='{}'].[resourceTypes[*].resourceType]" -o yaml`
## Azure service Principle
Create a service principle with password
```sh
az ad sp create-for-rbac --name mysp
az ad sp delete --id <appid>
az ad sp list --display-name mysp
az login --service-principal --username <appid> --password <password> --tenant <tenantid>
```
```json
  "appId": "xxxxx-xxxx-xxxx-xxxx-xxxxxxxxx",
  "displayName": "mysp",
  "password": "xxxxx~xxxxxxx-xxxxxxxxxxxxxxxxxxxxxx",
  "tenant": "xxxxxxx-xxxxxx-xxxxx-xxxxx-xxxxxxxx"
```

# RBAC
You can visit this [link](https://learn.microsoft.com/en-us/cli/azure/role/assignment?view=azure-cli-latest#az-role-assignment-create) and this [link](https://learn.microsoft.com/en-us/azure/role-based-access-control/built-in-roles) to check for built in roles, you can try by running the following: 
```sh
az role assignment create --assignee a87e7b2b-c264-4d44-aff6-571d2530e5e0 --role Owner
az role assignment list
```
[Some good ref env vars](https://github.com/Azure/azure-sdk-for-go/wiki/Set-up-Your-Environment-for-Authentication)
