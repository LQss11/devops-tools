# Secret management
## Image pull secret
```sh
kubectl create secret docker-registry regcred --docker-server=docker.io --docker-username=docker.io --docker-password=mypassword
```