# Vault Prod
First start your vault servers:
```sh
docker-compose up --build -d
```
unseal instances:
```sh
docker exec -it -u root node-1 sh -c "vault operator init -key-shares=3 -key-threshold=2 >/opt/vault/init_keys.txt"
# Repeat this process and put unseal keys to unseal vault on node
docker exec -it -u root node-1 sh -c "cat /opt/vault/init_keys.txt && vault operator unseal"
docker exec -it -u root node-1 sh -c "cat /opt/vault/init_keys.txt && vault login"
docker exec -it -u root node-1 sh -c "vault operator raft list-peers"
# Same for node-2 (use node-1 unseal keys)
docker exec -it -u root node-2 sh -c "vault operator unseal"
docker exec -it -u root node-2 sh -c "vault login && vault operator raft list-peers"
```
# Create a snapshot
```sh
# Make sure this is run on leader and as root for permissions
# Script automation that can be used in crontab daily: https://github.com/hashicorp/vault/issues/15258#issuecomment-1119339308
docker exec -it -u root node-1
vault operator raft snapshot save /opt/vault/data/raft/snapshots/$(date +%Y-%m-%d-%H).snap
vault operator raft snapshot restore filename.snap
```
to stop run this:
```sh
docker-compose down -v
```
# API Address
It's best to set a dns that will be changed over time as api address here is an example
```sh
# Use this or pass it in dns server and use resolver instead
echo $(nslookup node-1 | awk '/Address:/ {print $2}' | tail -1) vault-production >>/etc/hosts
```
