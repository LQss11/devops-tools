output "vnet_name" {
  value = azurerm_virtual_network.main.name
}
output "subnets" {
  value = azurerm_subnet.main
}