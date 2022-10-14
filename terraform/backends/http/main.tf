terraform {
  backend "http" {
    address = "http://localhost:5000/terraform_state/tf_state"
    lock_method = "PUT"
    lock_address = "http://localhost:5000/terraform_lock/tf_state"
    unlock_method = "DELETE"
    unlock_address = "http://localhost:5000/terraform_lock/tf_state"
  }
}

resource "random_id" "randomness" {
  byte_length = 6
}