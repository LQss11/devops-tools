output "security_group_ids" {
  value = module.nsg.security_group_ids
}

output "ssh_commands" {
  value = module.instance.ssh_commands
}
