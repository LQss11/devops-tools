# Docker swarm
docker-compose up --build -d --scale manager=3 --scale worker=3
docker-compose scale manager=1

docker exec -it swarm-manager-2 bash


docker node ls
docker stack deploy 
docker service create \
  --mode global \
  --publish mode=host,target=80,published=8080 \
  --name=nginx \
  nginx:alpine
