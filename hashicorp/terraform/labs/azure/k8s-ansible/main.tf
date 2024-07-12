# SSH setup
resource "tls_private_key" "generated" {
  algorithm = "RSA"
}
resource "local_file" "private_key_pem" {
  content         = tls_private_key.generated.private_key_openssh
  filename        = ".ssh/id_rsa"
  file_permission = "0100"

}
resource "local_file" "public_key_pem" {
  content         = tls_private_key.generated.public_key_openssh
  filename        = ".ssh/id_rsa.pub"
  file_permission = "0100"
}

# Azure stuff
resource "azurerm_resource_group" "main" {
  location = var.location
  name     = "${var.prefix}-k8s-ansible-${var.env}"
}

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
  vm_purpose = "ansible"
  size       = "Standard_A1_v2"
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
  vm_purpose = "master"
  size       = "Standard_B2s"
}
