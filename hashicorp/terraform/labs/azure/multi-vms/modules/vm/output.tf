output "pub_ips" {
  value = { for k, v in azurerm_public_ip.main : k => v.ip_address }
}
