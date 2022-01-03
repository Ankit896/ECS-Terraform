# VPC, Subnet
resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = "eks-vpc"
  }
}

resource "aws_subnet" "public_subnet" {
  count                   = length(var.aws_public_subnet_cidr_blocks)
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.aws_public_subnet_cidr_blocks[count.index]
  availability_zone       = var.aws_subnet_availability_zone[(count.index) % length(var.aws_subnet_availability_zone)] #var.aws_subnet_availability_zone
  map_public_ip_on_launch = true
  tags = {
    Name = tostring(join("_", ["eks-public-subnet", count.index]))
  }
}

resource "aws_subnet" "private_subnet" {
  count                   = length(var.aws_private_subnet_cidr_blocks)
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.aws_private_subnet_cidr_blocks[count.index]
  availability_zone       = var.aws_subnet_availability_zone[(count.index) % length(var.aws_subnet_availability_zone)] #var.aws_subnet_availability_zone
  map_public_ip_on_launch = false
  tags = {
    Name = tostring(join("_", ["eks-private-subnet", count.index]))
  }
}

# IGW, NAT Route, Route Association

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "eks-igw"
  }
}

resource "aws_nat_gateway" "ngw" {
  connectivity_type = "private"
  subnet_id         = aws_subnet.public_subnet[0].id
  tags = {
    Name = "eks-ngw"
  }
}

resource "aws_route_table" "public_route" {
  vpc_id = aws_vpc.vpc.id


  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id

  }
  tags = {
    Name = "eks-public-rt"
  }
}





resource "aws_route_table" "private_route" {
  vpc_id = aws_vpc.vpc.id
  route {


    cidr_block = var.aws_public_subnet_cidr_blocks[0]
    gateway_id = aws_nat_gateway.ngw.id


  }
  tags = {
    Name = "eks-private-rt"
  }
}

resource "aws_route_table_association" "route_association" {
  count          = length(aws_subnet.public_subnet[*].id)
  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.public_route.id #var.route_table_id

}


resource "aws_route_table_association" "route_associations" {
  count          = length(aws_subnet.private_subnet[*].id)
  subnet_id      = aws_subnet.private_subnet[count.index].id
  route_table_id = aws_route_table.private_route.id #var.route_table_id

}


#security group

resource "aws_security_group" "eks_security_group" {
  name   = var.security_group_name
  vpc_id = aws_vpc.vpc.id
  # ingress_with_cidr_blocks = var.eks_security_group_with_cidr_blocks
  tags = {
    Name = "eks-sg"
  }
}
