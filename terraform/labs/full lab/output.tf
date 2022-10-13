output "hello-work" {
  description = "Print a Hello World text"
  value       = "Hello World"
}
output "vpc_id" {
  description = "Output of the ID for the primary VPC"
  value       = aws_vpc.vpc.id
}
output "public_url" {
  description = "Public url for our web server"
  value       = "https://${aws_instance.web_server.private_ip}:8080/index.html"
}
output "ubuntu_server_public_url" {
  description = "Public url for our web server"
  value       = "https://${aws_instance.ubuntu_server.public_ip}:8080/index.html"
}
output "vpc_information" {
  description = "VPC Information about enviornmnet"
  value       = "Your ${aws_vpc.vpc.tags.Environment} VPC has an ID of ${aws_vpc.vpc.id}"
}
