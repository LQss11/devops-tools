# Coredns
Coredns is the dns used in kubernetes for container and could also be used as a dns server.
# Quick start
## Docker
```sh
# Create coredns container
docker run --rm -d --name coredns -p 53:53/udp -p 53:53/tcp -v ${pwd}/Corefile:/Corefile coredns/coredns:latest -conf /Corefile
```
### Test example
```sh
docker run -it --rm -d -p 8009:80 nginx:alpine
docker run -it --rm alpine sh 
# Inside docker alpine 
apk add curl && nslookup host.docker.internal | grep Address | tail -1 | cut -d: -f2 | xargs -I{} echo 'nameserver {}' > /etc/resolv.conf
curl nginx3.local:8009
```

## Docker compose
```sh
docker-compose up
```
### Test example
```sh
docker exec -it alpine sh -c "apk add curl"
# Test hosts from default directive
docker exec -it alpine sh -c "curl nginx.local"
# Test hosts from example directive
docker exec -it alpine sh -c "curl example.org"
```

# Info 
You could get more info about the corefile from [here](https://github.com/coredns/coredns/blob/master/corefile.5.md).