
# eks-cluster-09
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role
resource "aws_iam_role" "eks-fargate-demo-profile-role-01" {
  name = "eks-fargate-demo-profile-role-01"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "eks-fargate-pods.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

# eks-fargate-01
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_fargate_profile
resource "aws_eks_fargate_profile" "fargate-demo-01" {
  cluster_name           = aws_eks_cluster.eks-demo-cluster-01.name
  fargate_profile_name   = "fargate-demo-01"
  pod_execution_role_arn = aws_iam_role.eks-fargate-demo-profile-role-01.arn
  subnet_ids = [
    aws_subnet.eks-demo-private-01.id,
    aws_subnet.eks-demo-private-02.id
  ]
  selector {
    namespace = "kube-system"
    labels = {
      k8s-app="kube-dns"
    }
  }
  selector {
    namespace = "demo"
  }
  selector {
    namespace = "default"
  }
  selector {
    namespace = "example"
  }
}

# eks-fargate-02
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment
resource "aws_iam_role_policy_attachment" "eks-demo-fargate-profile-01" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSFargatePodExecutionRolePolicy"
  role       = aws_iam_role.eks-fargate-demo-profile-role-01.name
}
