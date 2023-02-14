output "user_access_keys" {
  value = nonsensitive(sensitive(aws_iam_access_key.user_access_keys.id))
}
