resource "azurerm_network_security_group" "main" {
  for_each            = var.subnets
  name                = "${var.prefix}-nsg-${each.key}"
  location            = var.location
  resource_group_name = var.resource_group
  tags                = var.tags
}


resource "azurerm_network_security_rule" "example" {
  for_each = {
    for subnet_name, subnet_config in var.subnets : subnet_name => subnet_config.inbound_ports
  }

  name                        = "nsr-${each.key}-${each.value[0]}"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.resource_group
  network_security_group_name = azurerm_network_security_group.main[each.key].name
}





# This works with range
# resource "azurerm_network_security_rule" "main_inbound" {
#   for_each = {
#     for subnet_key, subnet in var.subnets : subnet_key => subnet.security_rules
#   }

#   name                        = "${each.key}-nsr"
#   priority                    = 100
#   direction                   = "Inbound"
#   access                      = "Allow"
#   protocol                    = "Tcp"
#   source_port_range           = "*"
#   destination_port_range      = join(",", each.value)
#   source_address_prefix       = "*"
#   destination_address_prefix  = "*"
#   resource_group_name         = var.resource_group
#   network_security_group_name = azurerm_network_security_group.main[each.key].name
# }

# resource "azurerm_network_security_rule" "example" {
#   for_each                    = var.subnets
#   name                        = "rule-${each.key}"
#   priority                    = 100
#   direction                   = "Inbound"
#   access                      = "Allow"
#   protocol                    = "Tcp"
#   source_port_range           = var.subnets[each.key].security_rules
#   destination_port_range      = "*"
#   source_address_prefix       = "*"
#   destination_address_prefix  = "*"
#   resource_group_name         = var.resource_group
#   network_security_group_name = azurerm_network_security_group.main[each.key].name
# }



# resource "azurerm_network_security_rule" "main_inbound" {
#   for_each = {
#     for subnet_key, subnet in var.subnets : subnet_key => flatten([for i, rule in subnet.security_rules : { rule = rule, index = i }])
#   }

#   name                        = "${each.key}-nsr-${each.value.index}"
#   priority                    = 100 + each.value.index * 10
#   direction                   = "Inbound"
#   access                      = "Allow"
#   protocol                    = "Tcp"
#   source_port_range           = "*"
#   destination_port_range      = each.value.rule
#   source_address_prefix       = "*"
#   destination_address_prefix  = "*"
#   resource_group_name         = var.resource_group
#   network_security_group_name = azurerm_network_security_group.main[each.key].name
# }


# # Assign security group to the subnet
# resource "azurerm_subnet_network_security_group_association" "main" {
#   for_each                  = var.subnets
#   subnet_id                 = azurerm_subnet.main[each.key].id
#   network_security_group_id = azurerm_network_security_group.main[each.key].id
# }
