resource "tls_private_key" "generated" {
  algorithm = "RSA"
}
resource "local_file" "private_key_pem" {
  content         = tls_private_key.generated.private_key_openssh
  filename        = "${var.prefix}-id_rsa"
  file_permission = "0600"
}
resource "local_file" "public_key_pem" {
  content         = tls_private_key.generated.public_key_openssh
  filename        = "${var.prefix}-id_rsa.pub"
  file_permission = "0600"
}
