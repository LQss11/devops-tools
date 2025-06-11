# resource "kubernetes_secret" "azure_cloud_provider" {
#   metadata {
#     name      = "azure-cloud-provider"
#     namespace = "kube-system"
#   }

#   data = {
#     "cloud-config" = file("./cloud.json")
#   }

#   type = "Opaque"
# }

# # kubectl edit -n kube-system deploy/cloud-controller-manager
# # - --cloud-config-secret-name=azure-cloud-provider
# # - --cloud-config-key=cloud-config
# # - --cloud-config-secret-namespace=kube-system
# # - --enable-dynamic-reloading