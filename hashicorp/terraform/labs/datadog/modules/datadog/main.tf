# Create a new Datadog - Microsoft Azure integration
# resource "datadog_integration_azure" "sandbox" {
#   tenant_name              = var.tenant_id
#   resource_collection_enabled = true
#   client_id                = var.client_id
#   client_secret            = var.client_secret
#   host_filters             = var.common_fiter
#   app_service_plan_filters = var.common_fiter
#   container_app_filters    = var.common_fiter
#   automute                 = true
#   cspm_enabled             = true
#   custom_metrics_enabled   = false
# }

resource "datadog_dashboard_json" "dashboard_json" {
  dashboard = file("${path.module}/dashboard.json")
}

resource "datadog_api_key" "docker" {
  name = "docker-key"
}
