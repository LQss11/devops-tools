# Kubernetes
You can find one of the most commands and tips I usually need to work with k8s.

```sh
kubectl create deployment nginx --image=nginx:alpine --dry-run="client" -o yaml >deployment.yaml
```

## Kubernetres API
You can explore the kubernetes api by exposing the api server port:
```sh
kubectl proxy --port=8080
curl http://localhost:8080/api/
```
Get available rbac permissions:
```sh
kubectl auth can-i --list
```

# CLI
To update the text editor make sure to configure this env var **KUBE_EDITOR**
```sh
# Powershell
$env:KUBE_EDITOR="code -w"; kubectl edit -n default service/kubernetes
# Linux
KUBE_EDITOR="code -w"; kubectl edit -n default service/kubernetes
```