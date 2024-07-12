resource "azurerm_linux_virtual_machine" "main" {
  count = var.node_count

  name                = "${var.vm_purpose}-node-${count.index}"
  location            = var.location
  resource_group_name = var.rg
  size                = var.size
  network_interface_ids = [
    azurerm_network_interface.main[count.index].id,
  ]
  admin_ssh_key {
    username   = var.username
    public_key = var.public_key_content
    # public_key = file("${path.root}/.ssh/id_rsa.pub")
  }
  
  admin_username                  = var.username
  admin_password                  = var.password
  disable_password_authentication = false
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

