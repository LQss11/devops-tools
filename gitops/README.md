# Extract kubeconfig value
The followin way is how to create a kubeconfig from an existing argocd connection.
```sh
# Get existing argocd secrets
kubectl -n argocd get secrets
# Extract config params
kubectl get  secret --namespace argocd  mycluster.cloud.example  -o json | jq -r '.data.config' | base64 -d | jq -r '.tlsClientConfig | to_entries[] | "\(.key): \(.value)"'
# Extract erver param
kubectl get  secret --namespace argocd  mycluster.cloud.example  -o json | jq -r '.data.server' | base64 -d | jq -r '.tlsClientConfig | to_entries[] | "\(.key): \(.value)"'
```