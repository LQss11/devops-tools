output "ssh_commands" {
  value = [for pip in module.instance.public_ip : "ssh -i ${var.ssh_key_name}.pem ubuntu@${pip}"]
}
output "public_dns" {
  value = [for pdns in module.instance.public_dns : pdns]
}