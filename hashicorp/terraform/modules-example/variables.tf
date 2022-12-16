variable "environment" {
  description = "The ENV name"
  default     = "dev"
}
variable "location" {
  description = "deploy location"
  default     = "West Europe"
}
variable "resource_group" {
  description = "Azure rg"
  default     = "myrg"
}
variable "vault_password" {
  description = "example password"
  default     = "P@$$WORD123"
}

variable "tags" {
  description = "Some tags description"
  default     = {
    tag1 = "value1"
    tag2    = "value2"
    env  = "dev"
  }
}