resource "azurerm_public_ip" "main" {
  count               = var.vm_purpose == "ansible" ? var.node_count : 0
  name                = "${var.prefix}-${var.vm_purpose}-public-ip-${count.index}-${var.env}"
  location            = var.location
  resource_group_name = var.rg
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "main" {
  count = var.node_count

  name                = "${var.prefix}-${var.vm_purpose}-nic-${count.index}-${var.env}"
  location            = var.location
  resource_group_name = var.rg

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"

    # Conditionally attach public IP if it exists
    public_ip_address_id = length(azurerm_public_ip.main[*].id) > 0 ? azurerm_public_ip.main[count.index].id : null
  }
}
