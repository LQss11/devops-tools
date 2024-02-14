# Vault migration
To migrate vault storage usually you must be moving from a specific storage to **raft** storage to do this you can do the following:
- override command + entrypoint and enter container with tty=true
- make sure you create a **migrate.hcl** file containing the source and target stroage destination (**PS:** paths of destination must be created)
- Get in container and run the following
```sh
docker exec -it -u root vault-server-1 bash
# Run and wait until vault copies all data
vault operator migrate -config=/path/to/migrate.hcl

```
- Now once you have all your raft data you can create a volume with it and mount it or you can copy it to the container in the path where new raft configuration specified target dir then run the instance with new config


# Copy data to new volume
```sh
# Import new raft data from vault
docker cp vault-server-1:/opt/vault/data raft/
# Create new volume
docker volume create vault-raft-storage
# Crate container to allow us to manage volume
docker run -it --rm -d --name=volume-manager -v vault-raft-storage:/data -w /data alpine sh -c "tail -f /dev/null"
# Move to raft dir and copy data to the new volume
cd raft
docker cp . volume-manager:/data/ 
docker exec -it volume-manager sh -c "chmod -R 600 /data/"
```


# More
- [vault migration docs](https://developer.hashicorp.com/vault/docs/commands/operator/migrate)
- [Common issue: context deadline exceeded](https://github.com/hashicorp/vault/issues/18188)
- [About raft](https://developer.hashicorp.com/vault/docs/configuration/storage/raft)