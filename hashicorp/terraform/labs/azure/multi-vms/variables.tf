variable "prefix" {
  default = "multivms"
}

variable "subnets" {
  default = {
    "subnet" = {
      inbound_ports = ["22", "1433"]
      vms = {
        test = {
          name     = "examplevm1",
          size     = "Standard_B1ls",
          username = "adminuser"
        },
        test2 = {
          name     = "examplevm2",
          size     = "Standard_B1ls",
          username = "adminuser"
        }
      }
    },
    "subnet2" = {
      inbound_ports = ["22", "80", "443"]
      vms = {
        test3 = {
          name     = "examplevm3",
          size     = "Standard_B1ls",
          username = "adminuser"
        }
      }
    }
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
