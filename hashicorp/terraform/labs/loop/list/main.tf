variable "randlist" {
  type    = list(number)
  default = [1,2,10,3]
}

resource "random_id" "randomness" {
  count = length(var.randlist)
  byte_length = var.randlist[count.index]
}
