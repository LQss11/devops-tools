[
    {
        "name": "tomcat",
        "image": "tomcat:alpine",
        "cpu": 256,
        "memory": 512,
        "essential": true,
        "portMappings": [
            {
                "containerPort": 8080,
                "hostPort": 8080,
                "protocol": "tcp"
            }
        ]
    }
]