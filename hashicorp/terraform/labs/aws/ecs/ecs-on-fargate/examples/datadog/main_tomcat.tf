
data "aws_ecs_task_definition" "tomcat" {
  task_definition = aws_ecs_task_definition.tomcat.family
}

resource "aws_ecs_task_definition" "tomcat" {
  family                   = "tomcat"
  depends_on               = [aws_cloudwatch_log_group.datadog_agent_log_group]
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "512"
  memory                   = "1024"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = templatefile("${path.module}/task_definition_tomcat.tpl", {
    # variable = var.key
  })


  tags = var.tags
}

data "aws_network_interface" "tomcat" {
  # 1. Set `enable_ecs_managed_tags = true` in your aws_ecs_service. This will tag the network interface with
  #    aws:ecs:serviceName = <aws_ecs_service.yourservice.name>
  #    aws:ecs:clusterName  = <aws_ecs_service.yourservice.cluster>

  # 2. Use tag filter to identify the network interface  
  filter {
    name   = "tag:aws:ecs:serviceName"
    values = [aws_ecs_service.tomcat.name]
  }
  depends_on = [aws_ecs_service.tomcat]
}

resource "aws_ecs_service" "tomcat" {
  name          = "tomcat-service"
  cluster       = aws_ecs_cluster.nginx_cluster.id
  desired_count = 1
  # Those 2 are needed to retrieve the public ip
  enable_ecs_managed_tags = true # It will tag the network interface with service name
  wait_for_steady_state   = true # Terraform will wait for the service to reach a steady state 

  launch_type     = "FARGATE"
  task_definition = "${aws_ecs_task_definition.tomcat.family}:${max(aws_ecs_task_definition.tomcat.revision, data.aws_ecs_task_definition.tomcat.revision)}"

  network_configuration {
    subnets          = module.vpc.public_subnets
    security_groups  = [aws_security_group.tomcat_sg.id]
    assign_public_ip = true
  }

  tags = var.tags
}
