resource "azurerm_resource_group" "main" {
  name     = "default-${var.prefix}"
  location = "East US"
}

module "network" {
  source         = "./modules/network"
  prefix         = var.prefix
  resource_group = azurerm_resource_group.main.name
  location       = azurerm_resource_group.main.location
  vnet_name      = "${var.prefix}-vnet"
  address_space  = var.address_space
  subnets        = var.subnets
  tags           = var.tags
}

module "ssh" {
  source = "./modules/ssh"
  prefix = var.prefix
}

module "vm" {
  source         = "./modules/vm"
  prefix         = var.prefix
  resource_group = azurerm_resource_group.main.name
  location       = azurerm_resource_group.main.location
  subnets        = var.subnets
  subnet_details = module.network.subnets
  tags           = var.tags
  public_key_pem = module.ssh.public_key_pem
  depends_on     = [module.ssh]
}
