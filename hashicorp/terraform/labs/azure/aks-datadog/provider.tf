provider "azurerm" {
  features {}
  # export AZURE_SUBSCRIPTION_ID="xxxx"
  # $env:ARM_SUBSCRIPTION_ID="xxxx"
  # subscription_id = "xxxx"
}


provider "kubernetes" {
  config_path = "${path.module}/${var.kubeconfig_name}"
  # config_context = "my-context"
}

provider "helm" {
  kubernetes {
    config_path = "${path.module}/${var.kubeconfig_name}"
  }
}
