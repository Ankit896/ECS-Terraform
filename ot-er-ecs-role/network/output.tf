output "vpc" {
  value = aws_vpc.vpc.id
}

output "public_subnet" {
  value = aws_subnet.public_subnet[*].id
}

output "private_subnet" {
  value = aws_subnet.private_subnet[*].id
}

output "igw" {
  value = aws_internet_gateway.igw.id
}


output "eks_security_group" {
  value = aws_security_group.eks_security_group.id
}