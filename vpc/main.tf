################### vpc main #####################3
resource "aws_vpc" "main" {
  cidr_block = var.vpc_main.cidr_block
  tags       = merge(local.tags, { Name = "devops_vpc" })
}
#
resource "aws_subnet" "devops_public_subnet_0" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.vpc_main.public_subnet_0
  tags       = merge(local.tags, local.tags_alb.public_subnet, { Name = "devops_public_subnet_0" })
}
#
resource "aws_subnet" "devops_public_subnet_1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.vpc_main.public_subnet_1
  tags       = merge(local.tags, local.tags_alb.public_subnet, { Name = "devops_public_subnet_1" })
}
#
resource "aws_subnet" "devops_private_subnet_0" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.vpc_main.private_subnet_0
  tags       = merge(local.tags, { Name = "devops_private_subnet_0" })
}
#
resource "aws_subnet" "devops_private_subnet_1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.vpc_main.private_subnet_1
  tags       = merge(local.tags, { Name = "devops_private_subnet_1" })
}
#
#################################################################################################
#
resource "aws_subnet" "eks_control_panel_0" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.vpc_main.eks_control_panel_0
  tags       = merge(local.tags, { Name = "eks_control_panel_0" })
}
#
resource "aws_subnet" "eks_control_panel_1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.vpc_main.eks_control_panel_1
  tags       = merge(local.tags, { Name = "eks_control_panel_1" })
}
#
resource "aws_subnet" "eks_data_panel_0" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.vpc_main.eks_data_panel_0
  tags       = merge(local.tags, local.tags_alb.private_subnet, { Name = "eks_data_panel_0" })
}
#
resource "aws_subnet" "eks_data_panel_1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.vpc_main.eks_data_panel_1
  tags       = merge(local.tags, local.tags_alb.private_subnet, { Name = "eks_data_panel_1" })
}
#
#################################################################################################
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags   = merge(local.tags, { Name = "devops" })
}
#
resource "aws_internet_gateway_attachment" "main" {
  internet_gateway_id = aws_internet_gateway.main.id
  vpc_id              = aws_vpc.main.id
}
#
resource "aws_eip" "main" {
  domain = "vpc"
  tags   = merge(local.tags, { Name = "devops" })
}
#
resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.main.id
  subnet_id     = aws_subnet.devops_public_subnet_0.id
  tags          = merge(local.tags, { Name = "devops-nat" })
  depends_on    = [aws_internet_gateway.main]
}
#
resource "aws_route_table" "devops-public" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }
  route {
    cidr_block         = "10.0.0.0/8"
    transit_gateway_id = var.transit_gateway_id
  }
  tags = merge(local.tags, { Name = "devops-public" })
}
#
resource "aws_route_table" "devops-private" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main.id
  }
  route {
    cidr_block         = "10.0.0.0/8"
    transit_gateway_id = var.transit_gateway_id
  }
  tags = merge(local.tags, { Name = "devops-private" })
}
#
resource "aws_route_table_association" "devops_public_subnet_0" {
  subnet_id      = aws_subnet.devops_public_subnet_0.id
  route_table_id = aws_route_table.devops-public.id
}
#
resource "aws_route_table_association" "devops_public_subnet_1" {
  subnet_id      = aws_subnet.devops_public_subnet_1.id
  route_table_id = aws_route_table.devops-public.id
}



