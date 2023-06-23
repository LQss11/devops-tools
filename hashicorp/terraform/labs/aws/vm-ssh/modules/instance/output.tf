output "ssh_commands" {
  value = [for instance in aws_instance.main : "ssh -i ${var.ssh_key_name}.pem ubuntu@${instance.public_ip}"]
}
