# Create resource group
resource "azurerm_resource_group" "test" {
  name     = "test-rg"
  location = "East US"
}
# Generate SSH key pair
resource "tls_private_key" "generated" {
  algorithm = "RSA"
}

resource "local_file" "private_key_pem" {
  content  = tls_private_key.generated.private_key_pem
  filename = "sshkey.pem"
}

# Create virtual network
resource "azurerm_virtual_network" "test" {
  name                = "test-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = "East US"
  resource_group_name = azurerm_resource_group.test.name
}

# Create subnet
resource "azurerm_subnet" "test" {
  name                 = "test-subnet"
  resource_group_name  = azurerm_resource_group.test.name
  virtual_network_name = azurerm_virtual_network.test.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Create public IP
resource "azurerm_public_ip" "test" {
  name                = "test-pip"
  resource_group_name = azurerm_resource_group.test.name
  location            = "East US"
  allocation_method   = "Static"

  tags = {
    environment = "test"
  }
}

# Create network interface
resource "azurerm_network_interface" "test" {
  name                = "test-nic"
  resource_group_name = azurerm_resource_group.test.name
  location            = "East US"

  ip_configuration {
    name                          = "test-nic-ipconfig"
    subnet_id                     = azurerm_subnet.test.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.test.id
  }
}

resource "azurerm_virtual_machine" "main" {
  name                = "test-vm"
  resource_group_name = azurerm_resource_group.test.name
  location            = "East US"
  vm_size                = "Standard_B1ls"

  network_interface_ids = [azurerm_network_interface.test.id]

  delete_os_disk_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    managed_disk_type = "Standard_LRS"
    create_option     = "FromImage"
  }

  os_profile {
    computer_name  = "hostname"
    admin_username = "testadmin"
    admin_password = "Password1234!"
  }
  os_profile_linux_config {
    disable_password_authentication = false
    ssh_keys {
      path     = "/home/testadmin/.ssh/authorized_keys"
      key_data = tls_private_key.generated.public_key_openssh
    }
  }
  tags = {
    environment = "staging"
  }
}