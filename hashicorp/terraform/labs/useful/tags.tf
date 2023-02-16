# References
# # tags = var.tags
# # variable "tags" { type = map(any) }


variable "tags" {
  description = "Base Tags"
  default = {
    Project   = "projname"
    Terraform = "true"
  }
}

# Append to defaults
  tags = merge(
    var.tags,
    {
      Environment = var.environment
      Owner       = "myname"
    }
  )