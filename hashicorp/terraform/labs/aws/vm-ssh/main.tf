module "instance" {
  instance_count = 3
  source         = "./modules/instance"
  ami            = "ami-0c55b159cbfafe1f0" # Ubuntu 20.04 LTS
  instance_type  = "t2.micro"
  ssh_key_name   = var.ssh_key_name
  nsgs           = module.nsg.security_group_ids
}

module "ssh" {
  source       = "./modules/ssh"
  ssh_key_name = var.ssh_key_name
}
module "nsg" {
  source = "./modules/nsg"
  ports = {
    ssh = 22
    http = 80
    https = 443
  }
}
