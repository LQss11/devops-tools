resource "azurerm_virtual_network" "main" {
  name                = "${var.prefix}-k8s-ansible-${var.env}"
  address_space       = var.vnet_cidr
  location            = var.location
  resource_group_name = var.rg
}

resource "azurerm_subnet" "main" {
  name                 = "${var.prefix}-k8s-ansible-${var.env}"
  resource_group_name  = var.rg
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = var.subnet_cidr
}

resource "azurerm_network_security_group" "main" {
  name                = "main-nsg"
  location            = var.location
  resource_group_name = var.rg
}

resource "azurerm_network_security_rule" "main" {
  name                        = "${var.prefix}-ssh-inbound-${var.env}"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.rg
  network_security_group_name = azurerm_network_security_group.main.name
}

resource "azurerm_subnet_network_security_group_association" "main" {
  subnet_id                 = azurerm_subnet.main.id
  network_security_group_id = azurerm_network_security_group.main.id
}

