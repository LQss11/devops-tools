# Single line create token
```sh
kubectl create serviceaccount vault
kubectl create clusterrole full --verb=* --resource=* --resource=*
kubectl create clusterrolebinding vault:full --clusterrole=full --serviceaccount=default:vault
# secret must be created with annotatioion (couldn't find a straightforward way to create it with kubectl)
# kubectl create secret generic vault-secret --type=kubernetes.io/service-account-token --from-literal=kubernetes.io/service-account.name=vault
# Extract token
kubectl -n default get secret vault-secret -o=jsonpath='{.data.token}' | base64
```
# SA Token long
```sh
kubectl apply -f .
# Get the token
kubectl -n default get secret vault-secret -o=jsonpath='{.data.token}' | base64 -d && echo
# Get ca.crt
kubectl -n default get secret vault-secret -o=jsonpath='{.data.ca\.crt}' | base64 -d && echo
# Get namespace
kubectl -n default get secret vault-secret -o=jsonpath='{.data.namespace}' | base64 -d && echo
# Get cluster server
kubectl config view --minify --output=jsonpath='{.clusters[0].cluster.server}' && echo
```
# Kubectl command with token
## Create kubeconfig
```sh
KUBECONFIG=myconfig kubectl config set-cluster kubernetes --server=$(kubectl config view --minify --output=jsonpath='{.clusters[0].cluster.server}') --certificate-authority <(echo "$(kubectl -n default get secret v-root-vaulttes-1707146163-yzqjinxv6ucjk7ogcnubppt9-token-prc69 -o=jsonpath='{.data.ca\.crt}')" | base64 -d) --embed-certs
KUBECONFIG=myconfig kubectl config set-credentials mysa --token="$(kubectl -n default get secret v-root-vaulttes-1707146163-yzqjinxv6ucjk7ogcnubppt9-token-prc69 -o=jsonpath='{.data.token}' | base64 -d)"
KUBECONFIG=myconfig kubectl config set-context mysa --cluster=kubernetes --user=mysa
KUBECONFIG=myconfig kubectl config use-context mysa
```
