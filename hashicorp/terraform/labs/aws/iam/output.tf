output "user_access_keys" {
  value = {
    for i, user in var.users :
    aws_iam_user.users[i].name => [
      {
        account_id = aws_iam_user.users[i].arn
        username   = var.users[i]
        password   = nonsensitive(sensitive(aws_iam_user_login_profile.user_login_profile[i].password))
      },
      {
        access_key = nonsensitive(sensitive(aws_iam_access_key.user_access_keys[i].id))
        secret_key = nonsensitive(sensitive(aws_iam_access_key.user_access_keys[i].secret))
      }
    ]
  }
}
