resource "azurerm_resource_group" "example" {
  name     = contains(var.env_variable, "dev") ? "dev" : "prod"
  location = "westus"
}

variable "env_variable" {
  default = "development"
}
