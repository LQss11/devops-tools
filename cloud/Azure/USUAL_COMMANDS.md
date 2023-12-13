# Usaual commands
The following are commands that I use most frequently:
```sh
# List available subscriptions
az account list --output table
# Select a subscription
az account set --subscription subscription_id
# Get current account info
az account show --output table
# Get all resource groups in selected subscription
az group list -o table
# Get all resources in a resource group
az resource list -g rg_name
```