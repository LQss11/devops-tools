# Docker registry
- In order to create a registry run:
```sh
docker volume create docker-registry
docker run -d -p 5000:5000 --restart=always --name registry -v "docker-registry:/var/lib/registry" -v "$pwd/Docker/docker-registry/registry/config.yaml:/etc/docker/registry/config.yml:ro" registry:2
```
- Push image to the reg:
```sh
docker pull alpine
docker tag alpine localhost:5000/alpine
docker push localhost:5000/alpine
# One line push
IMAGE=alpine && docker tag $IMAGE localhost:5000/$IMAGE && docker push localhost:5000/$IMAGE
```
- check images url/check variants:
```sh
http://localhost:5000/v2/_catalog
http://localhost:5000/v2/<name>/tags/list
```
- remove images `docker image remove localhost:5000/alpine`
- pull images `docker pull localhost:5000/alpine`

## INFO
followed docker docs for creating registry click [here](https://docs.docker.com/registry/deploying/) to see more

[Docker registry api](https://docs.docker.com/registry/spec/api/#detail)
[Github example using a registry ui container](https://github.com/slydeveloper/docker-registry-joxit-ui-compose)
add the following to `daemon.json` if you have issues with accessing your registry:
```json
{
  "insecure-registries": ["localhost:5000"]
}
```