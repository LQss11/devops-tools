# Redis with go
You can connect and interact with redis using go, to run a quick test suite you can run the following commands:
```sh
# Start docker container
docker-compose up -d
# Check connection to redis by running py script
docker exec -it go sh -c "go run ."
```
You can verify that the data got inserted in our redis instance:
```sh
docker exec -it redis-go sh -c "echo == NUMBER OF DATA == && redis-cli dbsize && echo == KEYS == && redis-cli keys * && echo == NEW-KEY VALUE == && redis-cli GET NEW-KEY"
```