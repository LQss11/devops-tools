resource "aws_athena_named_query" "foo" {
  for_each  = fileset("${path.module}/scripts", "*.sql")
  name      = "QUERY_${each.key}"
  workgroup = aws_athena_workgroup.main.id
  database  = aws_athena_database.main.name
  query     = templatefile("${path.module}/scripts/${each.key}", { bucket_name = var.bucket_name })
}