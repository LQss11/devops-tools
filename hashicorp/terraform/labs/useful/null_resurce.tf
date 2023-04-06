resource "null_resource" "some_command" {
  provisioner "local-exec" {
    command = <<-EOT
      echo "file content" >myfile.txt
      cat myfile.txt
    EOT
  }
}
