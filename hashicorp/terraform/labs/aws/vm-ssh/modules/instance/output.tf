output "info" {
  value = {
    for index, instance in aws_instance.main :
    aws_instance.main[index].tags.Name => [
      {
        ssh_command     = "ssh -i ${var.ssh_key_name}.pem ubuntu@${aws_instance.main[index].public_ip}"
        public_ip       = aws_instance.main[index].public_ip
        security_groups = jsonencode(aws_instance.main[index].security_groups)
        public_dns      = aws_instance.main[index].public_dns
      }
    ]
  }
}
