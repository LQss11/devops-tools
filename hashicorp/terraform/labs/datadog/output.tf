output "portal_url" {
  value = "https://portal.azure.com/"
}

output "dashboard_url" {
  value = "${var.api_url}${module.datadog.dashboard_url}"
}

output "docker_api_key" {
  value = nonsensitive(sensitive(module.datadog.docker_api_key))
}