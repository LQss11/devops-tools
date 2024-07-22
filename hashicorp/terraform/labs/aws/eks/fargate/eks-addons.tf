
# eks-cluster-06
# Addones
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_addon
resource "aws_eks_addon" "eks-demo-addon-coredns" {
  cluster_name                = aws_eks_cluster.eks-demo-cluster-01.name
  addon_name                  = "coredns"
  addon_version               = "v1.10.1-eksbuild.4" 
  resolve_conflicts_on_create = "OVERWRITE" 
}

# A problem happened so i had to import coredns addon
# import {
#   to = aws_eks_addon.eks-demo-addon-coredns
#   id = "${aws_eks_cluster.eks-demo-cluster-01.name}:coredns"
# }

# eks-cluster-08
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_addon
resource "aws_eks_addon" "eks-demo-addon-vpc-cni" {
  cluster_name                = aws_eks_cluster.eks-demo-cluster-01.name
  addon_name                  = "vpc-cni"
  addon_version               = "v1.15.1-eksbuild.1" 
  resolve_conflicts_on_create = "OVERWRITE" 
}