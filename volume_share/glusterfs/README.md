# glusterfs
This is an example to simulate a glusterfs use case
## Gluster join node and create volume
```sh
# Start docker compose
docker-compose up -d
# Join peer
docker exec -it glusterfs sh -c "gluster peer probe glusterfs2"
docker exec -it glusterfs sh -c "gluster pool list"
# Create volume
docker exec -it glusterfs sh -c "gluster volume create testvol replica 2 glusterfs:/mnt glusterfs2:/mnt force"
# Start volume
docker exec -it glusterfs sh -c "gluster volume start testvol"
```
## DIND test
```sh
# Install glusterfs plugin
docker exec -it dind sh -c "docker plugin install --grant-all-permissions  --alias glusterfs urbitech/glusterfs"
# Create volume
docker exec -it dind sh -c "docker volume create -d glusterfs -o servers=glusterfs,glusterfs2 -o volname=testvol -o subdir=def testvol"
# Create docker container with volume

docker exec -it dind sh
docker run -it --rm -v testvol:/test -w /test alpine
docker exec -it glusterfs2 bash -c "ls /mnt/def"   
```