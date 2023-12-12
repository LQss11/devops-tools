output "public_key_pem" {
  value = tls_private_key.generated.public_key_openssh
}