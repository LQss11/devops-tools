output "pub_ips" {
  value = { for k, v in azurerm_public_ip.main : k => v.ip_address }
}

output "private_ips" {
  value = { for k, v in azurerm_linux_virtual_machine.main : k => v.private_ip_address }
}
