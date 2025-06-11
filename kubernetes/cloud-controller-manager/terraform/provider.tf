
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      # version = "=3.0.0"
      version = "3.110.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
  skip_provider_registration = true
  subscription_id            = var.subscription_id
  tenant_id                  = var.tenant_id
  client_id                  = var.client_id
  client_secret              = var.client_secret
}


provider "helm" {
  kubernetes {
    config_path = "~/.kube/config" # Adjust path if needed
  }
}
provider "kubernetes" {
  config_path = "~/.kube/config" # Adjust path if needed
}

