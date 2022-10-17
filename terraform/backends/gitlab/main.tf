terraform {
  backend "http" {
    username = "gitlab"
    password = "token"
    address = "https://gitlab.com/api/v4/projects/<project_id>/terraform/state/new-state-name"
    lock_method = "POST"
    lock_address = "https://gitlab.com/api/v4/projects/<project_id>/terraform/state/new-state-name/lock"
    unlock_method = "DELETE"
    unlock_address = "https://gitlab.com/api/v4/projects/<project_id>/terraform/state/new-state-name/lock"
  }
}

resource "random_id" "randomness" {
  byte_length = 5
}
