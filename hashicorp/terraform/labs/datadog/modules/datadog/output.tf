output "dashboard_url" {
  value = datadog_dashboard_json.dashboard_json.url
}

output "docker_api_key" {
  value = datadog_api_key.docker.key
}