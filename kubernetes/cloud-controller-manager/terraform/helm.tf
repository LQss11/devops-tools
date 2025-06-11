# resource "helm_release" "azure_ccm" {
#   name       = "azure-ccm"
#   repository = "https://raw.githubusercontent.com/kubernetes-sigs/cloud-provider-azure/master/helm/repo"
#   chart      = "cloud-provider-azure"

#   depends_on = [kubernetes_secret.azure_cloud_provider]

#   set {
#     name  = "cloud-provider-azure.infra.clusterName"
#     value = "mycluster-tf"
#   }

#   #   set {
#   #     name  = "cloud-provider-azure.cloudControllerManager.cloudConfig"
#   #     value = ""
#   #   }

#   set {
#     name  = "cloud-provider-azure.cloudControllerManager.cloudConfigSecretName"
#     value = kubernetes_secret.azure_cloud_provider.metadata[0].name
#   }

#   set {
#     name  = "cloud-provider-azure.cloudControllerManager.enableDynamicReloading"
#     value = "true"
#   }

#   set {
#     name  = "cloud-provider-azure.cloudControllerManager.configureCloudRoutes"
#     value = "true"
#   }

#   set {
#     name  = "cloud-provider-azure.cloudControllerManager.allocateNodeCidrs"
#     value = "true"
#   }

#   set {
#     name  = "cloud-provider-azure.cloudControllerManager.imageRepository"
#     value = "mcr.microsoft.com/oss/kubernetes"
#   }
# }
