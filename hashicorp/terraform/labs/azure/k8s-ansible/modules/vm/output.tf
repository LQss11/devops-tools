output "public_ip_addresses" {
  value = length(azurerm_public_ip.main) > 0 ? [for idx in range(length(azurerm_public_ip.main)) : azurerm_public_ip.main[idx].ip_address] : []
}
output "private_ips" {
  value = {
    for idx, vm in azurerm_linux_virtual_machine.main : "${vm.name}" => azurerm_network_interface.main[idx].ip_configuration[0].private_ip_address
  }
}