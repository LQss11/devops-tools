resource "local_file" "athena_jdbc_dsn" {
  filename = "${path.module}/template/example.env"
  content = templatefile("${path.module}/template/example.tpl", {
    myvar1                = var.var1
    myvar2                = var.var2
  })
}
