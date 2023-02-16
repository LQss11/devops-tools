output "public_ip" {
  value = [for instance in aws_instance.main : instance.public_ip]
}
output "public_dns" {
  value = [for instance in aws_instance.main : instance.public_dns]
}