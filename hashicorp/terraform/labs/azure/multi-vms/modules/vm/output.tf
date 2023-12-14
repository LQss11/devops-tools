output "virtual_machines" {
  value = { for k, v in azurerm_linux_virtual_machine.main : k => v }
}
