# Ngrok
## Docker
```sh
# Create network
docker network create ngrok
# Start a web app
docker run -it --rm --net ngrok --name nginx -d nginx 
# Host ngrok app using NGROK_AUTHTOKEN [Use  -p 3000:4040  if needed dashboard]
docker run -it --net ngrok -e NGROK_AUTHTOKEN=<TOKEN> --name ngrok ngrok/ngrok:alpine http nginx:80
```
## Docker compose
```sh
docker-compose up -d 
docker-compose exec ngrok ngrok http nginx:80
docker-compose exec ngrok ngrok http file:///var/log
```
# Authentication token
https://dashboard.ngrok.com/get-started/your-authtoken
