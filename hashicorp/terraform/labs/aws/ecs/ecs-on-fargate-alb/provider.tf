provider "aws" {
  # access_key = "xxxxxxxxxxxxxxxxxxxxxxxxxxx"
  # secret_key = "xxxxxxxxxxxxxxxxxxxxxxxxxxx"
  region     = "us-east-1"
  default_tags {
    tags = {
      Name = "terraform"
    }
  }
}
