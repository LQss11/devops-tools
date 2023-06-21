# Make sure this is commented on first run
# terraform {
#   backend "azurerm" {
#     resource_group_name  = "myrg"
#     storage_account_name = "mystorageaccount"
#     container_name       = "tfstate"
#     key                  = "prod.terraform.tfstate"
#     access_key           = "2a5eF4cd4j...WL8inBnN+icUIA6zeO+ASt3kdeNQ=="
#   }
# }
provider "azurerm" {
  features {}
  subscription_id = "00000000-0000-0000-0000-000000000000"
  client_id       = "00000000-0000-0000-0000-000000000000"
  client_secret   = "00000000-0000-0000-0000-000000000000"
  tenant_id       = "00000000-0000-0000-0000-000000000000"
}

resource "azurerm_resource_group" "state" {
  name     = "myrg"
  location = "West Europe"
}

resource "azurerm_storage_account" "state" {
  name                     = "mystorageaccountforstate"
  resource_group_name      = azurerm_resource_group.state.name
  location                 = azurerm_resource_group.state.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags = {
    environment = "state-management"
  }
#   lifecycle {
#     prevent_destroy = true
#   }
}

resource "azurerm_storage_container" "state" {
  name                  = "tfstate"
  storage_account_name  = azurerm_storage_account.state.name
  container_access_type = "private"
#   lifecycle {
#     prevent_destroy = true
#   }
}

output "access_key" {
  value     = "access_key=${azurerm_storage_account.state.primary_access_key}"
  sensitive = true
}


resource "local_file" "file" {
  content  = <<-EOT
    terraform {
      backend "azurerm" {
        resource_group_name  = "${azurerm_resource_group.state.name}"
        storage_account_name = "${azurerm_storage_account.state.name}"
        container_name       = "${azurerm_storage_container.state.name}"
        key                  = "prod.terraform.tfstate"
        access_key           = "${azurerm_storage_account.state.primary_access_key}"
      }
    }
  EOT
  filename = "terraform.tf"
}