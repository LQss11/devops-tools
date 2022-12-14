terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}
# Either uncomment and create tfvars file to define variables
# Or pass environment variables (read the readme file)
provider "azurerm" {
  features {}
#   subscription_id = var.subscription_id
#   client_id       = var.client_id
#   tenant_id       = var.tenant_id
#   client_secret   = var.client_secret
}

resource "azurerm_resource_group" "example" {
  location = "West Europe"
  name     = "authrgtest"
}