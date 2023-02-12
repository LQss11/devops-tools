# Build Docker Images
in order to build multiple docker images provided in this directory you can run the following:
```sh
IMAGE=ansible
TAG=alpine
docker build -t $IMAGE:$TAG -f ./docker/images/Dockerfile.$IMAGE.$TAG ./docker/images/
```