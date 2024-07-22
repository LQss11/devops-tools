provider "aws" {
  # access_key = "xxxxxxxxxxxxxxxxxxxx"
  # secret_key = "xxxxxxxxxxxxxxxxxxxx"
  region     = "us-east-1"
  default_tags {
    tags = {
      Name = "terraform"
    }
  }
}
