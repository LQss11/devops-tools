output "ssh_command" {
  value = "ssh -o StrictHostKeyChecking=no -i ${var.prefix}-id_rsa adminuser@${values(module.vm.pub_ips)[0]}"
}