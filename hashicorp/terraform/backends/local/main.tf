terraform {
  backend "local" {
    path = "terraform.tfstate"
  }
}

resource "random_id" "randomness" {
  byte_length = 6
}
