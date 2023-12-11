variable "prefix" { type = string }
variable "location" { type = string }
variable "resource_group" { type = string }
variable "vnet_name" { type = string }

variable "address_space" { type = string }
variable "subnets" { type = map(any) }

variable "tags" { type = map(any) }
