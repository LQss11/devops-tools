resource "azurerm_linux_virtual_machine" "main" {
  count = var.node_count

  name                = "${var.prefix}-${var.vm_purpose}-node-${count.index}-${var.env}"
  location            = var.location
  resource_group_name = var.rg
  size                = var.size
  admin_username      = "lqss"
  network_interface_ids = [
    azurerm_network_interface.main[count.index].id,
  ]

  admin_ssh_key {
    username   = "lqss"
    public_key = file("${path.root}/.ssh/id_rsa.pub")


  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}
