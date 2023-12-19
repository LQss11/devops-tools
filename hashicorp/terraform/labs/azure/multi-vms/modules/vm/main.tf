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
    username   = each.value.username
    public_key = var.public_key_pem
  }
  admin_username = each.value.username

  os_disk {
    caching              = each.value.os_disk.caching
    storage_account_type = each.value.os_disk.storage_account_type
    disk_size_gb         = each.value.os_disk.disk_size_gb
  }

  source_image_reference {
    publisher = each.value.image_settings.publisher
    offer     = each.value.image_settings.offer
    sku       = each.value.image_settings.sku
    version   = each.value.image_settings.version
  }
}
