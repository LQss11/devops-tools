resource "random_id" "main" {
  byte_length = 3
}
locals {
  random_var = lower(replace(random_id.main.id, "/[^a-zA-Z0-9]/", ""))
}

resource "random_string" "suffix" {
  length  = 8
  upper   = false
  special = false
  numeric = true
  lower   = true
}

resource "random_integer" "example" {
  min = 100
  max = 999
  keepers = {
    first = timestamp()
  }
}