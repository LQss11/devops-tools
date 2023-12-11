resource "azurerm_virtual_network" "main" {
  name                = var.vnet_name
  address_space       = [var.address_space]
  location            = var.location
  resource_group_name = var.resource_group

  tags = var.tags
}

resource "azurerm_subnet" "main" {
  for_each             = var.subnets
  name                 = "${var.prefix}-subnet-${each.key}"
  resource_group_name  = var.resource_group
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = [cidrsubnet(var.address_space, 8, index(keys(var.subnets), each.key))]
}

