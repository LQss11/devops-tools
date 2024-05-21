provider "datadog" {
  # Configuration options
  # Region is important check (https://docs.datadoghq.com/getting_started/site/)
  api_url = var.api_url

  app_key = var.app_key
  api_key = var.api_key
}