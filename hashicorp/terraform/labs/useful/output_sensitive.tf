output "resource_secret" {
  value = nonsensitive(sensitive(resource.name.secret))
}
