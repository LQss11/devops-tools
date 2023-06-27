resource "aws_security_group" "root" {
  for_each    = var.ports
  name        = "nsg-${each.key}-${each.value}"
  description = "Allow ${each.key} access"

  ingress {
    from_port   = each.value
    to_port     = each.value
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
