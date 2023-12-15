variable "subnets" {
  default = {
    "subnet" = {
      inbound_ports = ["22", "3389", "1433"]
    },
    "subnet2" = {
      inbound_ports = ["1433"]
    }
  }
}

locals {
  expanded_subnets = flatten([
    for subnet, details in var.subnets : [
      for port in details.inbound_ports : {
        subnet = subnet
        port   = port
      }
    ]
  ])
}

resource "local_file" "myfiles" {
  for_each = { for item in local.expanded_subnets : "${item.subnet}-${item.port}" => item }

  filename = "${each.value.subnet}-${each.value.port}"
  content  = "${each.value.port}"
}
