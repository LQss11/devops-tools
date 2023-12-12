resource "azurerm_network_security_group" "main" {
  for_each            = var.subnets
  name                = "${var.prefix}-nsg-${each.key}"
  location            = var.location
  resource_group_name = var.resource_group
  tags                = var.tags
}

# Assign security group to the subnet
resource "azurerm_subnet_network_security_group_association" "main" {
  for_each                  = var.subnets
  subnet_id                 = azurerm_subnet.main[each.key].id
  network_security_group_id = azurerm_network_security_group.main[each.key].id
}

resource "azurerm_network_security_rule" "inbound" {
  for_each = { for idx, item in local.expanded_subnets : idx => item }

  name                        = "${var.prefix}-Inbound-${each.value.subnet}-${each.value.port}"
  priority                    = 100 + tonumber(each.key) # Convert each.key to a number for numeric operations
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = each.value.port
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.resource_group
  network_security_group_name = azurerm_network_security_group.main[each.value.subnet].name
}

resource "azurerm_network_security_rule" "Outbound" {
  for_each                    = var.subnets
  name                        = "${var.prefix}-AllowAllOutbound-${each.key}"
  priority                    = 1000
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.resource_group
  network_security_group_name = azurerm_network_security_group.main[each.key].name
}
