resource "azurerm_public_ip" "main" {
  for_each            = { for idx, item in local.flattened_subnets : idx => item }
  name                = "${var.prefix}-${each.value.name}-pip"
  resource_group_name = var.resource_group
  location            = var.location
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "main" {
  for_each            = { for idx, item in local.flattened_subnets : idx => item }
  name                = "${var.prefix}-${each.value.name}-nic"
  resource_group_name = var.resource_group
  location            = var.location

  ip_configuration {
    name                          = "${var.prefix}-${each.value.name}-nic-ipconfig"
    subnet_id                     = var.subnet_details[each.value.subnet].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.main[each.key].id
  }
  tags = var.tags
}
