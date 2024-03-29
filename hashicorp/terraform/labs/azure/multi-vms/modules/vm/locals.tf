locals {
  expanded_subnets = flatten([
    for subnet, details in var.subnets : [
      for vm, vm_details in details.vms : {
        subnet         = subnet
        vm             = vm
        name           = vm_details.name
        size           = vm_details.size
        username       = vm_details.username
        image_settings = vm_details.image_settings
        os_disk        = vm_details.os_disk
      }
    ]
  ])
}
