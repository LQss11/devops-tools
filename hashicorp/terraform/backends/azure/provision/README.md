Create storage account and container first:
```sh
terraform apply -auto-approve 
```
Once storage account have been created uncomment the remote config add the key and then run this to import state to the storage account and no you can add more resources:
```sh
terraform init -migrate-state
```