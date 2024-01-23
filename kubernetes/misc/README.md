# Kubernetes misc
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
```