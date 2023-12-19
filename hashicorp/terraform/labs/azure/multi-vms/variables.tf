variable "prefix" {
  default = "multivms"
}

variable "address_space" {
  default = "10.50.0.0/16"
}

variable "subnets" {
  default = {
    "subnet" = {
      inbound_ports = ["22", "1433", "80", "6080", "5000"]
      vms = {
        openstack = {
          name     = "openstack-controller",
          size     = "Standard_D4s_v3",
          username = "adminuser",
          image_settings = {
            publisher = "Canonical"
            offer     = "UbuntuServer"
            sku       = "18_04-lts-gen2"
            version   = "latest"
          },
          os_disk = {
            caching              = "ReadWrite"
            storage_account_type = "Standard_LRS"
            disk_size_gb         = 64
          }
        }
        # vm2 = {
        #   name     = "vm2",
        #   size     = "Standard_B1ls",
        #   username = "adminuser",
        #   image_settings = {
        #     publisher = "Canonical"
        #     offer     = "0001-com-ubuntu-server-focal"
        #     sku       = "20_04-lts-gen2"
        #     version   = "latest"
        #   },
        #   os_disk = {
        #     caching              = "ReadWrite"
        #     storage_account_type = "Standard_LRS"
        #     disk_size_gb         = 64
        #   }
        # }
      }
    }
    # "subnet2" = {
    #   inbound_ports = []
    #   vms           = {}
    # }
  }
}

variable "tags" {
  description = "Some tags description"
  default = {
    ORGANIZATION = "myorg"
    PROJECT      = "multivms"
    TERRAFORM    = "true"
  }
}
