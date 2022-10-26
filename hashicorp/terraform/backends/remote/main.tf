terraform {
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "company"

    workspaces {
      name = "my-app-prod"
    }
  }
}
# Configure the AWS Provider
resource "random_id" "randomness" {
  byte_length = 6
}