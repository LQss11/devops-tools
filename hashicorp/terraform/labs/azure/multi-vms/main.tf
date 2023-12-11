resource "azurerm_resource_group" "main" {
  name = "default-${var.prefix}"
  location = "East US"
}

