# Redis with python
You can connect and interact with redis using python, to run a quick test suite you can run the following commands:
```sh
# Start docker container
docker-compose up -d
# Check connection to redis by running py script
docker exec -it python sh -c "python ./app.py"
```
You can verify that the data got inserted in our redis instance:
```sh
docker exec -it redis-python sh -c "echo == NUMBER OF DATA == && redis-cli dbsize && echo == KEYS == &&redis-cli keys * && echo == msg:hello VALUE == &&redis-cli GET msg:hello"
```