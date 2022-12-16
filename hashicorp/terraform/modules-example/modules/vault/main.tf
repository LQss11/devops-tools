# existing keyvault
data "azurerm_key_vault" "vault" {
  name                = var.name
  resource_group_name = var.resource_group
}
# password secrets
resource "azurerm_key_vault_secret" "my-password" {
  name         = "my-password"
  key_vault_id = data.azurerm_key_vault.vault.id
  value = var.my_password
  tags  = var.tags
}
