# Rover
create a terraform graph using rover
```sh
docker build -t rover .
docker run -it --rm -v ${pwd}:/app -w /app -p 9999:9000 rover rover
```