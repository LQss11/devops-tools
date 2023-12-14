output "ssh_command" {
  value = { for k, v in module.vm.virtual_machines : k => "ssh -o StrictHostKeyChecking=no -i multivms-id_rsa ${v.admin_username}@${v.public_ip_address}" }
}
output "private_ips" {
  value = { for k, v in module.vm.virtual_machines : k => v.private_ip_address }
}
