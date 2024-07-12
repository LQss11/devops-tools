# Default variables
variable "prefix" {
  default     = "lqss"
  description = "Information about the azure resources"
}
variable "env" {
  default     = "development"
  description = "Environment name"
}
# Azure variables
variable "location" {
  default     = "West Europe"
  description = "Location where to deploy all resources"
}

