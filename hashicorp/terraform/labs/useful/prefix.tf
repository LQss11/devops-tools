resource "random_string" "suffix" {
  length  = 4
  upper   = false
  special = false
  numeric = true
  lower   = true
}
# Prefix variable with a format of <prefix>-<4 random characters>
variable "prefix" {
  description = "Prefix for naming resources"
  type        = string
  default     = "example"
}

locals {
  prefix           = "${var.prefix}-${random_string.suffix.id}"
  sanitized_prefix = "${var.prefix}${random_string.suffix.id}"
}

output "prefix" {
  value = local.prefix
}
