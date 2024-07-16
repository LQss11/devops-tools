output "public_ip_address" {
  value = module.ansible.public_ip_addresses[0]
}
output "ssh_commands" {
  value = [
    for ip in module.ansible.public_ip_addresses : "ssh -i .ssh/id_rsa ${var.username}@${ip}"
  ]
}
output "ansible" {
  value = module.ansible.private_ips
}
output "master_nodes" {
  value = module.master.private_ips
}
output "worker_nodes" {
  value = module.worker.private_ips
}