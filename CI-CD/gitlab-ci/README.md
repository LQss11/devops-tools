# GITLAB
Following this example allows you to create a gitlab instance ready to be deployed using docker.
# Docker
```sh
docker-compose up -d
# Visit http://localhost:8080
```
once you made the instance is up and ready you can run:
```sh
docker exec -it ee63fcb857fb grep 'Password:' /etc/gitlab/initial_root_password
```
and now you can login as root user using the output password.


# Docs
for more information on how to set you instance and understand more preoblematic use cases make sure to check the official gitlab [documentation for docker](https://docs.gitlab.com/ee/install/docker.html).
