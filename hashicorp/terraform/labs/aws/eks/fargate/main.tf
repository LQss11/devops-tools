# https://gitlab.com/LianDuanTrainingGroup/awseks/-/blob/main/1-11%20EKS%20+%20Fargate%20+%20Terraform/Code/main.tf?ref_type=heads
# https://www.youtube.com/watch?v=oKD0sOsWI6M&ab_channel=Lian
# main.tf
# //////////////////////////////
#          Providers
# //////////////////////////////
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.39.0"
    }
  }
}

# //////////////////////////////
#          Resources
# //////////////////////////////

# eks-cluster-01
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_cluster
resource "aws_eks_cluster" "eks-demo-cluster-01" {
  name     = "eks-demo-cluster-01"
  version  = "1.28"
  role_arn = aws_iam_role.eks-demo-cluster-admin-role-01.arn
  vpc_config {
    subnet_ids              = [
      aws_subnet.eks-demo-public-01.id,
      aws_subnet.eks-demo-public-02.id,
      ]
    endpoint_public_access  = true
    endpoint_private_access = true
    public_access_cidrs     = ["0.0.0.0/0"]
  }
   access_config {
    authentication_mode = "API_AND_CONFIG_MAP"
    bootstrap_cluster_creator_admin_permissions = true
  }
  depends_on = [
    aws_iam_role_policy_attachment.eks-demo-cluster-01-AmazonEKSClusterPolicy,aws_iam_role_policy_attachment.eks-demo-cluster-01-AmazonEKSVPCResourceController
  ]
  tags = var.tags


}

# eks-cluster-07
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_addon
resource "aws_eks_addon" "eks-demo-addon-kube-proxy" {
  cluster_name                = aws_eks_cluster.eks-demo-cluster-01.name
  addon_name                  = "kube-proxy"
  addon_version               = "v1.28.2-eksbuild.2" 
  resolve_conflicts_on_create = "OVERWRITE" 
}

