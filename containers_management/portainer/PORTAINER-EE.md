# Portainer Enterprise Edition
This example will show you how to create a portainer business edition
```sh
# Get latest image version
docker image pull portainer/portainer-ee:latest
# Create portainer volume
docker volume create portainer_data
# Start portainer
docker run -d -p 9443:9443 --name=portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ee:latest
```
Once portiner is started You will be asked to enter the licence key and admin credentials to begin with.