# AKS
This example show how to provision a kubernetes cluster and convert manifests then deploy them using kubernetes provider.

# Converting manifests to terraform objects
```sh
# docker run -it --rm ubuntu bash -c "apt-get update && apt-get install -y tfk8s && bash"
# kubectl create deployment nginx --image nginx:alpine --kubeconfig .\config
# Already existing resource
kubectl get secrets sample -o yaml | tfk8s --strip -o sample.tf
# From manifest
cat deployment.yaml | tfk8s > deployment.tf
```