# nodejs
To create an nodejs app you can simply run this command:
```sh
# Create project
docker run --rm -it -v ${pwd}:/app -w /app node:alpine sh -c "npm init -y && npm install express"
# Run project
docker run --rm -it -v ${pwd}:/app -w /app node:alpine sh -c "npm install express winston mysql2 knex"
```