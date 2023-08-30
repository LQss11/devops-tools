# Follow this https://docs.docker.com/registry/deploying/

docker run -d -p 5000:5000 --restart=always --name registry -v "%cd%/mnt/registry:/var/lib/registry" registry:2
docker run -d -p 5000:5000 --restart=always --name registry -v "$pwd/mnt/registry:/var/lib/registry" registry:2


docker tag ubuntu:20.04 ub:20.04
docker tag ub:20.04 localhost:5000/ub
docker push localhost:5000/ub

http://localhost:5000/v2/_catalog


docker image remove ub:20.04 ub:latest localhost:5000/ub

docker pull localhost:5000/ub