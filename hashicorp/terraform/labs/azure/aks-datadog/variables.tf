variable "env" {
  default = "dev"
}
variable "kubeconfig_name" {
  default = "config"
}
variable "tags" {
  description = "Some tags description"
  default = {
    ORGANIZATION = "myorg"
    PROJECT      = "aks"
    TERRAFORM    = "true"
  }
}
