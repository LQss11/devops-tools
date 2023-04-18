output "ssh_command" {
  value = "ssh -i sshkey.pem testadmin@${azurerm_public_ip.test.ip_address}"
}