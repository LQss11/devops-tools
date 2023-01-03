variable "randmap" {
  default = {
    "random1" = 1
    "random2" = 11
    "random3" = 9
  }
}

resource "random_id" "randomness" {
  for_each    = var.randmap
  byte_length = each.value
}
