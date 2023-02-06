resource "aws_instance" "main" {
  ami           = var.ami
  instance_type = var.instance_type

  key_name = var.ssh_key_name

  vpc_security_group_ids = [aws_security_group.ssh.id]

  tags = {
    Name = var.instance_name
  }
}

resource "aws_security_group" "ssh" {
  name        = "ssh"
  description = "Allow SSH access"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
