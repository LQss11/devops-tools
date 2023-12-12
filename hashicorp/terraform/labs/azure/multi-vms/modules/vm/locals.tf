locals {
  flattened_subnets = flatten([
    for subnet, details in var.subnets : [
      for vm, vm_details in details.vms : {
        subnet   = subnet
        vm       = vm
        name     = vm_details.name
        size     = vm_details.size
        username = vm_details.username
      }
    ]
  ])
}
