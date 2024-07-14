resource "local_file" "ansible_hosts" {
  filename = "ansible/hosts.yml"
  content = templatefile("ansible/templates/hosts.tpl", {
    masters_private_ips = module.master.private_ips
    workers_private_ips = module.worker.private_ips
    username = var.username
  })
}

resource "null_resource" "copy_ssh_keys" {
  depends_on = [
    module.ansible, 
    local_file.ansible_hosts
  ]
  triggers = {
    always_run = "${timestamp()}"
  }
  connection {
    # Use the correct attribute to reference the Azure VM resource
    host     = module.ansible.public_ip_addresses[0]
    user     = var.username
    password = var.password # Note: Using passwords in plaintext is not recommended; consider using SSH keys instead
  }

  # Once all goo can test running this command
  # ansible -i hosts.yml all -m ping 
  # ansible-playbook -i hosts.yml kubernetes-cluster.yml
  provisioner "remote-exec" {
    inline = [
      "sudo apt-get -qqq update && sudo apt-get install -y -qqq  ansible",
      # "ansible -i ~/ansible/hosts.yml all -m ping"
    ]
  }
  provisioner "file" {
    source      = ".ssh/"
    destination = "/home/${var.username}/.ssh/"
  }
  provisioner "file" {
    source      = "ansible"
    destination = "/home/${var.username}/ansible"
  }
}
