terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.111.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "4.0.5"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.5.1"
    }
  }

}
