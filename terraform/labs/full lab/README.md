## Commands
terraform fmt (formatter)
terraform validate file_name (validate file)
terraform init
terraform plan
terraform apply auto-approve
terraform destroy auto-approve
terraform show (show the state)
terraform state list
terraform state show <resource_name>
terraform version (get version of terraform and providers that will be installed)
terraform providers (check whcih providers are required for our configuration)

terraform output -json

terraform apply -replace=<resource.res_name>
terraform taint <resource.res_name> (deprecated!!! taint resource to recreate it on next apply)
terraform untaint <resource.res_name>

terraform import <resource.res_name> <resource_id> (Import an existing resource configuration to terraform file "Use terraform state show <RESOURCE> and copy paste all required configuration")


terraform workspace show
terraform show (show if tfstate exist)
terraform workspace new development
terraform workspace select development
### Extra commands
terraform plan -out myplan (save plan with name)
terraform apply "myplan"


Debugging 
// TRACE DEBUG INFO WARN ERROR
export TF_LOG="TRACE"
//turn off
export TF_LOG=""

export TF_LOG_PATH="terraform_log.txt"
export TF_LOG_PATH=""

//powershell
setx TF_LOG="TRACE"
setx TF_LOG_PATH="terraform_log.txt"
