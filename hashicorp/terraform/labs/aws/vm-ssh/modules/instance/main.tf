resource "aws_instance" "main" {
  count         = var.instance_count
  ami           = var.ami
  instance_type = var.instance_type

  key_name = var.ssh_key_name

  vpc_security_group_ids = concat(var.nsgs, [aws_security_group.allow_all.id])
  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update"
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("${var.ssh_key_name}.pem")
      host        = self.public_ip
    }
  }
  # Will be executed once we launche the instance
  user_data = <<-EOF
    #!/bin/bash
    echo "ubuntu:ubuntu124" | chpasswd
  EOF
  tags = {
    Name = "myawsinstance${count.index + 1}"
  }
}


resource "aws_security_group" "allow_all" {
  name        = "allow-all-outbound-nsg"
  description = "Allow outbound traffic from all sources"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
