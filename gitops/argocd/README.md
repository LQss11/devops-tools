# Argocd

```sh
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
# Expose server port
kubectl port-forward svc/argocd-server -n argocd 8080:443
# Argocd admin password
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo
# Login using cli or interface
argocd login localhost:9900 --username=admin --password=8CdA6e6o1wwsHFsI
# You can then update password through cli e.g(adminadmin123)
argocd account update-password --account=admin 
# Get kubectl contexts with (kubectx or kubectl config get-contexts -o name) then run
# This will be the outpu "Cluster 'https://kubernetes.docker.internal:6443' added"
argocd cluster add docker-desktop
# Create new app
argocd app create guestbook --repo https://github.com/argoproj/argocd-example-apps.git --path guestbook --dest-server https://kubernetes.default.svc --dest-namespace default
# Another nginx app (localhost:30080)
argocd app create devops-nginx --repo https://github.com/LQss11/devops-tools --path gitops/argocd/manifests --dest-server https://kubernetes.default.svc --dest-namespace default 
# Make it sync automatically (if not applied)
argocd app set devops-nginx --sync-policy automated
# Expose port of app (localhost:8082)
kubectl port-forward svc/guestbook-ui 8082:80
# Once deployed you can delete it
argocd app delete guestbook
```

For more docs follow this [link](https://argo-cd.readthedocs.io/en/stable/getting_started/).

<!-- Once Installed you can expose port: 
```sh
$env:KUBE_EDITOR="code -w"; kubectl edit -n argocd svc/argocd-server
``` -->