
variable "prefix" {
  description = "Project prefix"
  type        = string
  default     = "cloud-controller-manager"
}

variable "subscription_id" {
  description = "Azure Subscription ID"
  type        = string
  default     = "xxxxxxxxxxxxxxxxxxxxxxx"
}

variable "tenant_id" {
  description = "Azure Tenant ID"
  type        = string
  default     = "xxxxxxxxxxxxxxxxxxxxxxx"
}

variable "client_id" {
  description = "Azure Client ID for Service Principal"
  type        = string
  default     = "xxxxxxxxxxxxxxxxxxxxxxx"
}

variable "client_secret" {
  description = "Azure Client Secret for Service Principal"
  type        = string
  default     = "xxxxxxxxxxxxxxxxxxxxxxx"
}
