variable "prefix" {
  default = "multivms"
}

variable "address_space" {
  default = "10.50.0.0/16"
}

variable "subnets" {
  default = {
    "subnet" = {
      inbound_ports = ["22", "1433"]
      vms = {
        openstack = {
          name     = "openstack-controller",
          size     = "Standard_D4s_v3",
          username = "adminuser"
        }
        # test2 = {
        #   name     = "examplevm2",
        #   size     = "Standard_B1ls",
        #   username = "adminuser"
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
