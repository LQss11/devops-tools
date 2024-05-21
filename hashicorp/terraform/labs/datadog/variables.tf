variable "client_id" {
  type        = string
  description = "Service Principle App ID"
  default     = "************************************"
}

variable "client_secret" {
  type        = string
  description = "Service Principle Password"
  default     = "************************************"
}

variable "tenant_id" {
  type        = string
  description = "Service Principle Tenant ID"
  default     = "************************************"
}

variable "subscription_id" {
  type        = string
  description = "Service Principle Subscription ID"
  default     = "************************************"
}

variable "api_key" {
  type        = string
  description = "Datadog terraform API key"
  default     = "************************************"
}

variable "api_url" {
  type        = string
  description = "Datadog API site url"
  default     = "https://us3.datadoghq.com"
}

variable "app_key" {
  type        = string
  description = "Datadog terraform application key"
  default     = "************************************"
}


variable "tags" {
  description = "Some tags description"
  default = {
    environment = "prod"
    PROJECT      = "datadog-azure-intrgation"
    TERRAFORM    = "true"
  }
}
