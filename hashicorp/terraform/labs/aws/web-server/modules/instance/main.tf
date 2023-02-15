resource "aws_instance" "main" {
  ami           = var.ami
  instance_type = var.instance_type

  key_name = var.ssh_key_name

  vpc_security_group_ids = [aws_security_group.main-sg.id]
  connection {
    user        = "ubuntu"
    private_key = var.private_key_pem
    host        = self.public_ip
  }
  provisioner "local-exec" {
    command = "chmod 600 ${var.ssh_key_name}.pem"
  }
  provisioner "remote-exec" {
    inline = [
      "sudo rm -rf /tmp",
      "sudo git clone https://github.com/hashicorp/demo-terraform-101 /tmp",
      "sudo sh /tmp/assets/setup-web.sh",
    ]
  }
  tags = {
    Name = var.instance_name
  }
  lifecycle {
    ignore_changes = [security_groups]
  }
}
resource "aws_security_group" "main-sg" {
  name        = "demo-security-group"
  description = "Web Traffic"
  ingress {
    description = "Allow Port 80"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Allow Port 443"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description        = "allow-all-ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = "Allow all ip and ports outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
