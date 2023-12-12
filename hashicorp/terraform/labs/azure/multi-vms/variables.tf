variable "prefix" {
  default = "multivms"
}

variable "subnets" {
  default = {
    "subnet" = {
      inbound_ports = ["22", "3389", "1433"]
      vms           = { example1 = { name = "myfirstvm"}}
    },
    "subnet2" = {
      inbound_ports = ["1433"]
      vms           = {}
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
