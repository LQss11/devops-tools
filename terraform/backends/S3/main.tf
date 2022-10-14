terraform {
  backend "s3" {
    bucket         = "my-terraform-state"
    access_key     = ""
    secret_key     = ""
    key            = "prod/aws_infra"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
# Configure the AWS Provider
resource "random_id" "randomness" {
  byte_length = 6
}