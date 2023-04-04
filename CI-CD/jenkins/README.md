# Jenkins
```sh
docker-compose -p jenkins -f docker-compose-controller.yaml up -d

docker-compose -p jenkins -f docker-compose-slave.yaml up -d
```

Path to environment variables [http://JENKINS_URL/env-vars.html/](http://JENKINS_URL/env-vars.html/)