# Terraform
You can run terraform using the cli or run the docker
```sh
# docker-compose
docker-compose up -d
docker exec -i terraform-cli sh -c "terraform init -upgrade"
# Docker
cat >.env <<EOF
ARM_CLIENT_ID=$(CLIENT_ID)
ARM_CLIENT_SECRET=$(CLIENT_SECRET)
ARM_SUBSCRIPTION_ID=$(SUBSCRIPTION_ID)
ARM_TENANT_ID=$(TENANT_ID)
EOF
docker run -d --name terraform-cli --env-file=".env" --entrypoint="" -w="/terraform" -v .:/terraform/staging hashicorp/terraform tail -f /dev/null
```

## Commands
```sh
# Basic Commands
terraform fmt # (formatter)
terraform validate file_name # (validate file)
terraform init # Initialize for providers and backend initialization
terraform plan # Compare actual config with state
terraform apply -auto-approve # Apply 
terraform destroy -auto-approve # Destroy config
terraform show # Show current resources state
terraform state list # (show the existing resources in a state)
terraform state show <resource_name>  # Show state of a specific resource
terraform version # (get version of terraform and providers that will be installed)
terraform providers # (check whcih providers are required for our configuration)
```

```sh
# More Commands
terraform output -json # Get the list of outputs

terraform plan -out myplan # (save plan in a file)
terraform apply "myplan"

terraform apply -replace=<resource.res_name> # (override and force update on a single resource)
terraform taint <resource.res_name> #(deprecated!!! taint resource to recreate it on next apply)
terraform untaint <resource.res_name> # 

terraform import <resource.res_name> <resource_id> # (Import an existing resource configuration to terraform file "Use terraform state show <RESOURCE> and copy paste all required configuration")

# Manage workspaces
terraform workspace new prod
terraform apply -auto-approve

terraform workspace new dev
terraform apply -auto-approve
terraform show

terraform workspace select prod
terraform show

terraform workspace show # Get existing workspaces
terraform workspace list # List workspaces
```

```sh
# Debugging 
## TRACE DEBUG INFO WARN ERROR
export TF_LOG="TRACE"
# turn off
export TF_LOG=""

export TF_LOG_PATH="terraform_log.txt"
export TF_LOG_PATH=""

# powershell
setx TF_LOG="TRACE"
setx TF_LOG_PATH="terraform_log.txt"
```

# MISC
```sh
terraform force-unlock f18eafa-ffz3-b390-a112-a374321qz4a5
```