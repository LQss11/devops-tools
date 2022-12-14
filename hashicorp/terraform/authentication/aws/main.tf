provider "aws" {
  access_key = "AKIA...IEXVPFI"
  secret_key = "+HRQJG743vTS...wU8I0btXB"
  # shared_credentials_files = "./path/to/.aws/creds"
  region = "us-east-1"
}

resource "aws_vpc" "example" {
  cidr_block = "10.0.0.0/16"
}