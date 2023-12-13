# output "ssh_command" {
#   value = "ssh -o StrictHostKeyChecking=no -i ${var.prefix}-id_rsa adminuser@${values(module.vm.pub_ips)}"
# }
output "ssh_command" {
  value = { for k, v in module.vm.pub_ips : k => "ssh -o StrictHostKeyChecking=no -i multivms-id_rsa adminuser@${v}" }
}

output "private_ips" {
  value = { for k, v in module.vm.private_ips : k => v }
}
