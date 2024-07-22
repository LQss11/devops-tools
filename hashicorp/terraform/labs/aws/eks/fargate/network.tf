# VPC-01
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc
resource "aws_vpc" "eks-demo-vpc-01" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "eks-demo-vpc-01"
  }
}
# VPC-02
# Public Subnet
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet
resource "aws_subnet" "eks-demo-public-01" {
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  vpc_id                  = aws_vpc.eks-demo-vpc-01.id
  map_public_ip_on_launch = true
  tags = {
    Name = "eks-demo-public-01"
  }
}
# VPC-03
# Private Subnet
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet
resource "aws_subnet" "eks-demo-private-01" {
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1a"
  vpc_id                  = aws_vpc.eks-demo-vpc-01.id
  map_public_ip_on_launch = true
  tags = {
    Name = "eks-demo-private-01"
  }
}
# VPC-04
# Public Subnet
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet
resource "aws_subnet" "eks-demo-public-02" {
  cidr_block              = "10.0.3.0/24"
  availability_zone       = "us-east-1b"
  vpc_id                  = aws_vpc.eks-demo-vpc-01.id
  map_public_ip_on_launch = true
  tags = {
    Name = "eks-demo-public-02"
  }
}
# VPC-05
# Private Subnet
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet
resource "aws_subnet" "eks-demo-private-02" {
  cidr_block              = "10.0.4.0/24"
  availability_zone       = "us-east-1b"
  vpc_id                  = aws_vpc.eks-demo-vpc-01.id
  map_public_ip_on_launch = true
  tags = {
    Name = "eks-demo-private-02"
  }
}
# VPC-06
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip
resource "aws_eip" "demo-eip-01" {
  domain                    = "vpc"
  depends_on = [aws_internet_gateway.eks-demo-internet-gateway-01]
  tags = {
    Name = "demo-eip-01"
  }
}
# VPC-07
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway
resource "aws_internet_gateway" "eks-demo-internet-gateway-01" {
  vpc_id = aws_vpc.eks-demo-vpc-01.id
  tags = {
    Name = "eks-demo-internet-gateway"
  }
}
# VPC-08
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway
resource "aws_nat_gateway" "eks-demo-internet-nat" {
  allocation_id = aws_eip.demo-eip-01.id
  subnet_id     = aws_subnet.eks-demo-public-01.id

  tags = {
    Name = "eks-demo-net-gateway"
  }

  depends_on = [aws_internet_gateway.eks-demo-internet-gateway-01]
}

# VPC-09
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table
resource "aws_route_table" "eks-demo-public" {
  vpc_id = aws_vpc.eks-demo-vpc-01.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.eks-demo-internet-gateway-01.id
  }

  tags = {
    Name = "eks-demo-public"
  }
}
# VPC-10
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table
resource "aws_route_table" "eks-demo-private" {
  vpc_id = aws_vpc.eks-demo-vpc-01.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.eks-demo-internet-nat.id
  }

  tags = {
    Name = "eks-demo-private"
  }
}
# VPC-11
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association
resource "aws_route_table_association" "private-us-east-1a" {
  subnet_id      = aws_subnet.eks-demo-private-01.id
  route_table_id = aws_route_table.eks-demo-private.id
}


# VPC-12
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association
resource "aws_route_table_association" "private-us-east-1b" {
  subnet_id      = aws_subnet.eks-demo-private-02.id
  route_table_id = aws_route_table.eks-demo-private.id
}

# VPC-13
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association
resource "aws_route_table_association" "public-us-east-1a" {
  subnet_id      = aws_subnet.eks-demo-public-01.id
  route_table_id = aws_route_table.eks-demo-public.id
}

# VPC-14
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association
resource "aws_route_table_association" "public-us-east-1b" {
  subnet_id      = aws_subnet.eks-demo-public-02.id
  route_table_id = aws_route_table.eks-demo-public.id
}
