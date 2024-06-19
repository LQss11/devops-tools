# Security
## Tools
### Nuclei
nuclei is a vulnerability scanner tool you will need to run those commands:
```sh
docker run -it --rm --entrypoint="" projectdiscovery/nuclei sh
# Update nuclei templates
nuclei -ut
# Scan host against all templates
nuclei -u host.app.com:8080
```
# Nikto
```sh
docker run -it --rm alpine sh
# install nikto
apk update && apk add nikto
# Scan host
nikto.pl -port 8080 -host host.app.com -Tuning 2
```
