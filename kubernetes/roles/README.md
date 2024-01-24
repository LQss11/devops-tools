# Manage K8s Roles and IAM
You can assign roles to users or service accounts 

- **Users**: are used through certs for example you can check [this url](https://kubernetes.io/docs/reference/access-authn-authz/rbac/#kubectl-create-rolebinding)
- **Service Accounts**: are mainly used to allow some containers to have access to the cluster through a token and cluster ca certificate you can find them bound on the running container under **/var/run/kubernetes.io/serviecaccount**

# Create role
Role and rolebinding could be namespaced oriented or cluster oriented so we have both role and clusterrole resourceses as well as rolebinding and clusterrolebinding. 

We can create them like this in this example we are using service account:
```sh
kubectl create serviceaccount demo
# If you want to get an idea about resources you can expose apiserver and check apis 
# by running `kubectl proxy 8080`
kubectl create clusterrole pod-reader --verb=get,list,watch --resource=pods,pods/log,pods/status
# Service account is defined like this "namespace:sa"
kubectl create clusterrolebinding demo-pod-reader --clusterrole=pod-reader --serviceaccount=default:demo
# In case it's a user not a service account
kubectl create clusterrolebinding exampleuser-pod-reader --clusterrole=pod-reader --user=exampleuser
# Role binding per namespace for group dev
kubectl create rolebinding -n default john-pod-reader --clusterrole=pod-reader --group=dev
```

# More Information
- [kubectl create clusterrole](https://kubernetes.io/docs/reference/access-authn-authz/rbac/#kubectl-create-clusterrole)
- [kubectl create clusterrolebinding](https://kubernetes.io/docs/reference/access-authn-authz/rbac/#kubectl-create-clusterrolebinding)