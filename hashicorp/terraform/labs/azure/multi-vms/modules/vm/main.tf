resource "azurerm_linux_virtual_machine" "main" {
  for_each            = { for idx, item in local.expanded_subnets : item.name => item }
  name                = "${var.prefix}-${each.value.name}"
  resource_group_name = var.resource_group
  location            = var.location
  size                = each.value.size
  network_interface_ids = [
    azurerm_network_interface.main[each.key].id
  ]

  admin_ssh_key {
    username = each.value.username
    # public_key = file("${path.root}/${var.prefix}-id_rsa.pub")
    public_key = var.public_key_pem
  }
  # disable_password_authentication= false
  admin_username = each.value.username
  #   admin_password = "Admin123"

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    # offer   = "UbuntuServer"
    sku     = "22_04-lts"
    version = "latest"
  }
}
