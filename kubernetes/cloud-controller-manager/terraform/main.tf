# resource "azurerm_resource_group" "example" {
#   name     = "${var.prefix}-rg"
#   location = "West Europe"
# }
# Import existing resource group
data "azurerm_resource_group" "main" {
  name = "Devops_Interns"
}
  
resource "azurerm_virtual_network" "main" {
  name                = "${var.prefix}-virtual-network"
  address_space       = ["10.10.0.0/16"]
  location            = data.azurerm_resource_group.main.location
  resource_group_name = data.azurerm_resource_group.main.name
}


resource "azurerm_network_security_group" "example" {
  name                = "${var.prefix}-nsg"
  location            = data.azurerm_resource_group.main.location
  resource_group_name = data.azurerm_resource_group.main.name
}
resource "azurerm_route_table" "example" {
  name                          = "${var.prefix}-route-table"
  location                      = data.azurerm_resource_group.main.location
  resource_group_name           = data.azurerm_resource_group.main.name
  disable_bgp_route_propagation = false

}


resource "azurerm_subnet" "example" {
  name                 = "internal"
  resource_group_name  = data.azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.10.1.0/24"]
}

resource "azurerm_network_interface" "example" {
  name                = "example-nic"
  location            = data.azurerm_resource_group.main.location
  resource_group_name = data.azurerm_resource_group.main.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.example.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.example.id
  }
}
resource "azurerm_public_ip" "example" {
  name                = "acceptanceTestPublicIp1"
  resource_group_name = data.azurerm_resource_group.main.name
  location            = data.azurerm_resource_group.main.location
  allocation_method   = "Static"


}

resource "azurerm_linux_virtual_machine" "example" {
  name                = "docker-desktop"
  resource_group_name = data.azurerm_resource_group.main.name
  location            = data.azurerm_resource_group.main.location
  size                = "Standard_B2s_v2"
  admin_username      = "ubuntu"
  network_interface_ids = [
    azurerm_network_interface.example.id,
  ]
  admin_ssh_key {
    username   = "ubuntu"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  connection {
    type        = "ssh"
    user        = self.admin_username
    private_key = file("~/.ssh/id_rsa")
    host        = azurerm_public_ip.example.ip_address
  }
  provisioner "file" {
    source      = "cloud.json"
    destination = "/home/${self.admin_username}/cloud.json"
  }
  provisioner "file" {
    source      = "kubernetes.sh"
    destination = "/home/${self.admin_username}/kubernetes.sh"
  }
  provisioner "remote-exec" {
    inline = [ 
      "sudo  chmod 777 /home/${self.admin_username}/kubernetes.sh",
      "export DEBIAN_FRONTEND=noninteractive",
      "sudo  bash +x /home/${self.admin_username}/kubernetes.sh"

     ]
  }


}



