module "key_vault" {
  source         = "./modules/vault"
  name           = "${var.resource_group}-${var.environment}-kv"
  resource_group = var.resource_group
  # secrets
  my_password = var.vault_password
  tags        = var.tags
}

# module example {
#     source                  = "./modules/example"
#     name                    = "${var.resource_group}-${var.environment}-kv"
#     resource_group          = var.resource_group
#
#     key_vault_id                = module.key_vault.id
#
#     tags                    = var.tags 
# }
