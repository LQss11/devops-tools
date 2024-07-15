
# Azure stuff
resource "azurerm_resource_group" "main" {
  location = var.location
  name     = "${var.prefix}-k8s-ansible-${var.env}"
}
# Vms sizes https://cloudprice.net/
# Example kubesphere https://kubesphere.io/docs/v3.3/installing-on-linux/public-cloud/install-kubesphere-on-azure-vms/
module "network" {
  source      = "./modules/network"
  location    = azurerm_resource_group.main.location
  rg          = azurerm_resource_group.main.name
  prefix      = var.prefix
  env         = var.env
  vnet_cidr   = ["10.0.0.0/16"]
  subnet_cidr = ["10.0.1.0/24"]
}
# SSH generator
module "ssh" {
  source = "./modules/ssh"
}
# Vms settings
module "ansible" {
  # vm_purpose = "ansible" could not have more than 1 node conunt
  # only vm_purpose = "ansible" could have a public ip
  source     = "./modules/vm"
  location   = azurerm_resource_group.main.location
  rg         = azurerm_resource_group.main.name
  prefix     = var.prefix
  env        = var.env
  node_count = 1
  subnet_id  = module.network.subnet_id
  # ansible/master/worker
  vm_purpose         = "ansible"
  size               = "Standard_F1"
  username           = var.username
  password           = var.password
  public_key_content = module.ssh.public_key_content
}

module "master" {

  # vm_purpose = "ansible" could not have more than 1 node conunt
  # only vm_purpose = "ansible" could have a public ip
  source     = "./modules/vm"
  location   = azurerm_resource_group.main.location
  rg         = azurerm_resource_group.main.name
  prefix     = var.prefix
  env        = var.env
  node_count = 1
  subnet_id  = module.network.subnet_id
  # ansible/master/worker
  vm_purpose         = "master"
  size               = "Standard_A2_v2"
  username           = var.username
  password           = var.password
  public_key_content = module.ssh.public_key_content
}
module "worker" {

  # vm_purpose = "ansible" could not have more than 1 node conunt
  # only vm_purpose = "ansible" could have a public ip
  source     = "./modules/vm"
  location   = azurerm_resource_group.main.location
  rg         = azurerm_resource_group.main.name
  prefix     = var.prefix
  env        = var.env
  node_count = 1
  subnet_id  = module.network.subnet_id
  # ansible/master/worker
  vm_purpose         = "worker"
  size               = "Standard_B2s"
  username           = var.username
  password           = var.password
  public_key_content = module.ssh.public_key_content
}
