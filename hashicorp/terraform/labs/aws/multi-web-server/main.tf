module "instance" {
  source        = "./modules/instance"
  instance_name = "example-instance"
  ami           = "ami-0c55b159cbfafe1f0" # Ubuntu 20.04 LTS
  instance_type = "t2.micro"
  ssh_key_name = var.ssh_key_name
  private_key_pem = module.ssh.private_key_pem
}
module "ssh" {
  source = "./modules/ssh"
  ssh_key_name = var.ssh_key_name
}
