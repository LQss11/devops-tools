data "aws_eks_cluster_auth" "example" {
  name = aws_eks_cluster.eks-demo-cluster-01.name
}

locals {
  kubeconfig_content = templatefile("${path.module}/kubeconfig.yaml.tpl", {
    cluster_id                 = aws_eks_cluster.eks-demo-cluster-01.id
    certificate_authority_data = aws_eks_cluster.eks-demo-cluster-01.certificate_authority[0].data
    endpoint                   = aws_eks_cluster.eks-demo-cluster-01.endpoint
    token                      = data.aws_eks_cluster_auth.example.token
  })
}

resource "local_file" "kubeconfig" {
  filename = "${path.module}/kubeconfig.yaml"
  content  = local.kubeconfig_content
}
