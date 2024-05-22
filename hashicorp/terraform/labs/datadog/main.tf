module "azure" {
  source          = "./modules/azure"
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  app_key         = var.app_key
  api_key         = var.api_key

  rg_name = "Myrg"
  tags    = var.tags
}

module "datadog" {
  source  = "./modules/datadog"
  api_url = var.api_url
  app_key = var.app_key
  api_key = var.api_key

  tenant_id     = var.tenant_id
  client_id     = var.client_id
  client_secret = var.client_secret

  common_fiter = "environment:prod"
}
