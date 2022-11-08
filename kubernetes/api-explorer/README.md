# Cluster Curl api explorer
Follow this example in order to allow specific POD with specific service account to run api requests to the host kubernetes cluster.
```sh
# Create service account
kubectl apply -f ./sa.yaml
# Create Cluster role
kubectl apply -f ./cluster-role.yaml
# Bind the cluster role to the service account
kubectl apply -f ./role-binding.yaml
# Creater service account token secret
kubectl apply -f ./sa-token-secret.yaml
```
Or you can apply all deployments at once :
```sh
kubectl apply -f .
kubectl delete -f .
```
Now you can get logs of all pods from a specific pod:
**Path to sa data inside the pod are in /var/run/secrets/kubernetes.io/serviceaccount/token**
```sh
# Get the API Server location (from host)
kubectl -n default get endpoints kubernetes
# Execute commands inside pod
kubectl exec -it deployment/nginx -- sh
# Execute the following commands and make sure you pass the right apiserver url
apk add jq && \
APISERVER=https://192.168.65.4:6443 && \
TOKEN=$(cat /var/run/secrets/kubernetes.io/serviceaccount/token)
```
```sh
# Get all pods names
curl -s $APISERVER/api/v1/namespaces/default/pods/ --header "Authorization: Bearer $TOKEN" --cacert /var/run/secrets/kubernetes.io/serviceaccount/ca.crt | jq -rM '.items[].metadata.name'
# ---> nginx-5dbb96fdb-4866g

# Get logs
curl -s $APISERVER/api/v1/namespaces/default/pods/nginx-5dbb96fdb-4866g/log --header "Authorization: Bearer $TOKEN" --cacert /var/run/secrets/kubernetes.io/serviceaccount/ca.crt
```
