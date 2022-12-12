# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used
terraform {
  backend "azurerm" {
    resource_group_name  = "myrg"
    storage_account_name = "mystorageaccount"
    container_name       = "tfstate"
    key                  = "prod.terraform.tfstate"
    access_key           = "2a5eF4cd4j...WL8inBnN+icUIA6zeO+ASt3kdeNQ=="
  }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
  subscription_id = "00000000-0000-0000-0000-000000000000"
  client_id       = "00000000-0000-0000-0000-000000000000"
  client_secret   = "00000000-0000-0000-0000-000000000000"
  tenant_id       = "00000000-0000-0000-0000-000000000000"
}
