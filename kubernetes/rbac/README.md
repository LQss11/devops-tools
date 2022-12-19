# RBAC Kubeconfig
We will be generating a kubeconfig where a developer can use to run specific tasks with limited permissions.
```sh
# Generate private key
openssl genrsa -out DevUser.key 2048
# CN=Common name
# O=Organization
# Generate cert request
openssl req -new -key DevUser.key -out DevUser.csr -subj "/CN=DevUser/O=development"
# Create a dev user cert
openssl x509 -req -in DevUser.csr -CA ./ca.crt -CAkey ./ca.key  -CAcreateserial -out DevUser.crt -days 365
# Generate a new user in the kubeconfig
kubectl config set-credentials DevUser --client-certificate ./DevUser.crt --client-key ./DevUser.key
# Assign a new context for the new user
kubectl config set-context DevUser --user=DevUser --cluster=docker-desktop --namespace=default
# Change the context
kubectl config get-contexts
kubectl config use-context DevUser
# Or you can specify in command directly
kubectl run nginx --image=nginx --context=DevUser
```

If you need the CA certificate you can get it by getting under `run/config/pki/ca.crt` in the cluster or if you have already a kubeconfig with a ca config (**it should be in b64**) make sure to convert it from b64 to verify the crt.
## Ref
[RBAC k8s](https://www.infracloud.io/blogs/role-based-access-kubernetes/)