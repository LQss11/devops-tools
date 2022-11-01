# Redis with node
You can connect and interact with redis using node, to run a quick test suite you can run the following commands:
```sh
# Start docker container
docker-compose up -d
```
You can verify that the data nodet inserted in our redis instance:
```sh
docker exec -it redis-node sh -c "echo == NUMBER OF DATA == && redis-cli dbsize && echo == KEYS == && redis-cli keys * && echo == NEW-KEY VALUE == && redis-cli GET mykey"
```