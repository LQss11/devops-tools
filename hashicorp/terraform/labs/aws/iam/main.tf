resource "aws_iam_user" "users" {
  count = length(var.users)
  name  = var.users[count.index]
}
resource "aws_iam_policy" "restricted_iam_access" {
  name = "restricted_iam_access"
  
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ec2:*"
        ]
        Resource = "*"
      },
      {
        Effect = "Deny"
        Action = [
          "iam:*"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_user_policy_attachment" "user_admin_access" {
  count      = length(var.users)
  user       = aws_iam_user.users[count.index].name
  policy_arn = aws_iam_policy.restricted_iam_access.arn
  # policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_access_key" "user_access_keys" {
  count = length(var.users)
  user  = aws_iam_user.users[count.index].name
}

resource "aws_iam_user_login_profile" "user_login_profile" {
  count    = length(var.users)
  user     = aws_iam_user.users[count.index].name
}