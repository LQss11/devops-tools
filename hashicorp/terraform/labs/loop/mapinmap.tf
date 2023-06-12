
variable "mapinmap" {
  description = "deploy location"
  default = {
    "group1" = {
      "key1" = "val1"
      "key2" = "val2"
    }
    "group2" = {
      "key3" = "val3"
      "key4" = "val4"
    }
  }
}


resource "some_resource" "main" {
  for_each = var.mapinmap
  # todo: Make name unique
  name       = "somename-${each.key}"
  keysvalues = each.key

  each_value_of_each_key = each.value[element(keys(each.value), length(each.value) - 1)]
}
