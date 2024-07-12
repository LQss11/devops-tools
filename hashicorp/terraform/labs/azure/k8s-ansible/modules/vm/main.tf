resource "azurerm_public_ip" "main" {
  count               = var.vm_purpose == "ansible" ? var.node_count : 0
  name                = "${var.vm_purpose}-${count.index}-public-ip"
  location            = var.location
  resource_group_name = var.rg
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "main" {
  count = var.node_count

  name                = "${var.vm_purpose}-${count.index}-nic"
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
