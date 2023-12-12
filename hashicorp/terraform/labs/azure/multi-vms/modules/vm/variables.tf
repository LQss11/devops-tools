variable "prefix" { type = string }
variable "location" { type = string }
variable "resource_group" { type = string }
variable "subnets" {}
variable "subnet_details" {}

variable "tags" { type = map(any) }
