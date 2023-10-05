resource "tls_private_key" "generated" {
  algorithm = "RSA"
}
resource "local_file" "private_key_pem" {
  content  = tls_private_key.generated.private_key_pem
  filename = "${var.ssh_key_name}.pem"
  file_permission = "0600"
}
resource "aws_key_pair" "ssh" {
  key_name   = var.ssh_key_name
  public_key = tls_private_key.generated.public_key_openssh
  lifecycle {
    ignore_changes = [key_name]
  }
}