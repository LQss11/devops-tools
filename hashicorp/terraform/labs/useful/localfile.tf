resource "local_file" "foo" {
  content = jsonencode({
    somevalue = nonsensitive(sensitive(module.mymodule1.value)),
    value2             = module.mymodule2.object_name,
  })

  filename = "config.json"
}
