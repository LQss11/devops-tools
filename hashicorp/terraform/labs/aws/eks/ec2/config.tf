data "aws_eks_cluster_auth" "example" {
  name = module.eks.cluster_name
}

locals {
  kubeconfig_content = templatefile("${path.module}/kubeconfig.yaml.tpl", {
    cluster_id                 = local.cluster_name
    certificate_authority_data = module.eks.cluster_certificate_authority_data
    endpoint                   = module.eks.cluster_endpoint
    token                      = data.aws_eks_cluster_auth.example.token
  })
}

resource "local_file" "kubeconfig" {
  filename = "${path.module}/kubeconfig.yaml"
  content  = local.kubeconfig_content
}

output "kubectl" {
  value= "kubectl --kubeconfig kubeconfig.yaml get nodes"
}