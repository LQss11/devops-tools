# Azure cloud controller manager
CCM in kubernetes allow us to automate the creating of load balancer in azure and configure it to be linked with our cluster, In this example we will see an example on how to configure the Azure cloud controller manager (CCM).

## Setup CCM config
Collect the following values from Azure, as they will be needed for the Azure authenticationn and CCM configuration  file.
* **Tenant ID**
* **Subscription ID**
* **Client ID**
* **Client Secret**

```sh
# Create Azure cloud-config  credentials
kubectl create secret generic azure-cloud-provider --from-file=cloud-config=./cloud.conf -n kube-system
# Install cloud controller manager chart
helm upgrade --install azure-ccm cloud-provider-azure/cloud-provider-azure --set infra.clusterName="cluster-example" --set cloudControllerManager.cloudConfig='' --set cloudControllerManager.cloudConfigSecretName="azure-cloud-provider" --set cloudControllerManager.enableDynamicReloading="true" --set cloudControllerManager.configureCloudRoutes="true" --set cloudControllerManager.allocateNodeCidrs="true" --set cloudControllerManager.imageRepository="mcr.microsoft.com/oss/kubernetes"
# Uninstall chart
helm uninstall azure-ccm
```

## Test load balancer service
```sh
kubectl apply -f deployment-test.yaml
kubectl delete -f deployment-test.yaml
```

# Guide
- [Azure cloud controller manager](https://www.talos.dev/v1.4/kubernetes-guides/configuration/azure-ccm-csi/)
- [cloud-provider-azure repo](https://github.com/kubernetes-sigs/cloud-provider-azure/tree/master/helm/cloud-provider-azure) 
