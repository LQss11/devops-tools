data "aws_ecs_task_definition" "nginx" {
  task_definition = aws_ecs_task_definition.nginx.family
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "my-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]
  # One NAT Gateway per availability zone
  enable_nat_gateway = true
  single_nat_gateway = false
  enable_vpn_gateway = true

  tags = var.tags
}

resource "aws_ecs_cluster" "nginx_cluster" {
  name = "nginx-cluster"
  
  tags = var.tags
}

resource "aws_ecs_task_definition" "nginx" {
  family                   = "nginx"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"

  container_definitions = <<DEFINITION
[
  {
    "name": "nginx",
    "image": "nginx:alpine",
    "cpu": 128,
    "memory": 128,
    "essential": true,
    "portMappings": [
      {
        "containerPort": 80,
        "hostPort": 80,
        "protocol": "tcp"
      }
    ]
  }
]
DEFINITION

  tags = var.tags
}

resource "aws_ecs_service" "nginx" {
  name            = "nginx"
  cluster         = aws_ecs_cluster.nginx_cluster.id
  desired_count   = 1
  launch_type     = "FARGATE"
  task_definition = "${aws_ecs_task_definition.nginx.family}:${max(aws_ecs_task_definition.nginx.revision, data.aws_ecs_task_definition.nginx.revision)}"

  network_configuration {
    subnets          = module.vpc.public_subnets
    security_groups  = [aws_security_group.nginx_sg.id]
    assign_public_ip = true
  }

  depends_on = []

  tags = var.tags
}

resource "aws_security_group" "nginx_sg" {
  name_prefix = "nginx-sg"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.tags
}

output "nginx_service_public_ips" {
  value = aws_ecs_service.nginx.network_configuration[0].assign_public_ip
  description = "The public IPs of the Nginx service."
}
