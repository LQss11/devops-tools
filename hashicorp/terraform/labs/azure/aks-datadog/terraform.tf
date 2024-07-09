terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.107.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.4.0"
    }  
    helm = {
      source = "hashicorp/helm"
      version = "2.13.2"
    }      
  }
}



