# Docker swarm
docker-compose up --build --scale manager=3 --scale worker=3 -d
docker exec -it swarm-manager-1 sh -c "docker service create --mode global -p 8080:80 --name=nginx nginx:alpine"
docker exec -it swarm-manager-1 sh -c "docker service rm nginx"

docker-compose -f ./load-balancer/docker-compose.yaml up --build


docker-compose down -v 



docker exec -it swarm-manager-1 sh -c "docker stack deploy -c /app/examples/prom-stack-docker-compose.yaml monitoring"
docker exec -it swarm-manager-1 sh -c "docker stack rm  monitoring"







docker-compose scale manager=1

docker exec -it swarm-manager-2 bash


docker node ls
docker stack deploy 