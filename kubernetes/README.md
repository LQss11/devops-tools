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
For authentication you can use the following:

```sh
# Open apiserver port
kubectl patch service/kubernetes -p '{"spec": {"type": "NodePort"}}'
kubectl get service/kubernetes -o jsonpath='{.spec.ports[0].nodePort}'
# Update apiserver clusters.cluster.server with your ip and service/kubernetes apiserver nodeport in kubeconfig or run the following command:
kubectl --server=<https://ip>:<service/kubernetes nodeport> get all --client-certificate=client.crt --client-key=client.key --insecure-skip-tls-verify=true
# Using kubectl proxy 
kubectl proxy --port=8888
kubectl --server=localhost:8888 --certificate-authority=ca.crt --client-certificate=client.crt --client-key=client.key get all
```
