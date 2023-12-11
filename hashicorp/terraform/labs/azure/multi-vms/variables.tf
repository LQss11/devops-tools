variable "prefix" {
  default = "multivms"
}


variable "subnets" {
  default = {
    "subnet" = {
      inbound_ports = ["22", "3389", "1433"]
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
