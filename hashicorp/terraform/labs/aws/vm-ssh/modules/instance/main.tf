resource "aws_instance" "main" {
  count         = var.instance_count
  ami           = var.ami
  instance_type = var.instance_type

  key_name = var.ssh_key_name

  vpc_security_group_ids = var.nsgs

  tags = {
    Name = "myawsinstance${count.index + 1}"
  }
}

