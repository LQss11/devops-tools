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