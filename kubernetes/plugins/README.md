# Kubernetes plugins
You can use kuberntes krew to manage plugins in the best way you can follow the [installation guide](https://krew.sigs.k8s.io/docs/user-guide/setup/install/)

By clicking on this url you will be downloading the latest release automatically [krew](https://github.com/kubernetes-sigs/krew/releases/latest/download/krew.exe)

Once downloaded make sure to install it:
```sh
# Open cmd as adminstrator
.\krew install krew
# Once install run this
setx PATH "%PATH%;%USERPROFILE%\.krew\bin"
# Now run
kubectl krew
# Some basic commans
kubectl krew index list
kubectl krew install access-matrix
kubectl krew info access-matrix
# Url for plugins list https://krew.sigs.k8s.io/plugins/
kubectl access-matrix for pods
# Update index to fetch new versions
kubectl krew update
# Upgrade package
kubectl krew upgrade grep
# Search for all plugins
kubectl krew search
kubectl krew search rbac
kubectl info tree
```
> PS: Running kubectl krew command require adminstrator access