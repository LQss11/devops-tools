
# eks-cluster-02
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document
data "aws_iam_policy_document" "eks-demo-cluster-admin-role-policy" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

# eks-cluster-03
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role
resource "aws_iam_role" "eks-demo-cluster-admin-role-01" {
  name               = "eks-demo-cluster-admin-role-01"
  assume_role_policy = data.aws_iam_policy_document.eks-demo-cluster-admin-role-policy.json
}
# eks-cluster-04
resource "aws_iam_role_policy_attachment" "eks-demo-cluster-01-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks-demo-cluster-admin-role-01.name
}

# eks-cluster-05
# Optionally, enable Security Groups for Pods
# Reference: https://docs.aws.amazon.com/eks/latest/userguide/security-groups-for-pods.html
resource "aws_iam_role_policy_attachment" "eks-demo-cluster-01-AmazonEKSVPCResourceController" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.eks-demo-cluster-admin-role-01.name
}
