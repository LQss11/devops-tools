# Docker command
docker run -d -v ${pwd}/server:/app -p 5000:5000 -w /app --name terraform-http-backend ubuntu:18.04 bash -c "tail -f /dev/null"
docker exec -it terraform-http-backend bash -c "./setup-env.sh"
# Docker compose
docker-compose up --build