resource "random_integer" "example" {
  min = 100
  max = 999
  keepers = {
    first = timestamp()
  }
}