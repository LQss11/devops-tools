# Role assignments
You can assign roles like this:
```sh
kubectl create clusterrolebinding user-admin-binding --clusterrole=cluster-admin --user="docker-desktop"
```