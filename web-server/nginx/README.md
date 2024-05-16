# Nginx
Simple nginx example with apache (httpd) and tomcat webservers redirection!
# Docker
To start the example you can simply run
```sh
docker run -it --rm -v ${pwd}/dist:/usr/share/nginx/html/ -w /app  -p 8777:80 nginx:alpine
```
# Docker compose
```sh
docker-compose up -d
```
## URIS redirection
**localhost:8880/httpd/** for apache and **localhost:8880/tomcat/** for tomcat server