# Vault Prod
First start your vault server:
```sh
docker-compose up --build -d
```
unseal instance:
```sh
docker exec -it vault-server sh -c "./tmp/script/unseal.sh"
```
to stop run this:
```sh
docker-compose down -v
```

## Info

Make sure to create a valid vault.crt and vault.key files under ./certs directory 
