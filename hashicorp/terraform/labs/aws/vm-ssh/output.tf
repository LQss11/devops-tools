output "ssh_command" {
  value = "ssh -i ${var.ssh_key_name}.pem ubuntu@${module.instance.public_ip}"
}