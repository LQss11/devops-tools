resource "local_file" "azure_json" {
  content = templatefile("${path.module}/cloud.json.tpl", {
    tenant_id                     = var.tenant_id
    subscription_id               = var.subscription_id
    client_id                     = var.client_id
    client_secret                 = var.client_secret
    azurerm_resource_group_name   = data.azurerm_resource_group.main.name
    azurerm_resource_group_location = data.azurerm_resource_group.main.location
    azurerm_network_security_group_name = azurerm_network_security_group.example.name
    azurerm_virtual_network_name  = azurerm_virtual_network.main.name
    azurerm_route_table_name      = azurerm_route_table.example.name
  })
  filename = "${path.module}/cloud.json"
}
