resource "random_id" "main" {
  byte_length = 4
}
locals {
  random_var = lower(replace(random_id.main.id, "/[^a-zA-Z0-9]/", ""))
}
