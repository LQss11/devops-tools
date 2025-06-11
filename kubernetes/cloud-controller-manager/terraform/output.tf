output "public_ip" {
  value = "ssh  -o StrictHostKeyChecking=no ${azurerm_linux_virtual_machine.example.admin_username}@${azurerm_public_ip.example.ip_address}"
}