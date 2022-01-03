# network variable

variable "vpc_cidr_block" {
  type    = string
  default = "13.0.0.0/16"

}
variable "vpc_name" {
  type    = string
  default = "eks_vpc"
}

variable "aws_public_subnet_cidr_blocks" {
  type    = list(any)
  default = ["13.0.8.0/24", "13.0.2.0/24"]
}
variable "aws_subnet_availability_zone" {
  type    = list(any)
  default = ["ap-south-1a", "ap-south-1b"]
}
variable "aws_private_subnet_cidr_blocks" {
  type    = list(any)
  default = ["13.0.3.0/24", "13.0.4.0/24"]
}

variable "security_group_name" {
  type    = string
  default = "my-sg"
}

variable "eks_security_group_with_cidr_blocks" {
  type    = list(any)
  default = [{ from_port = 22, to_port = 22, protocol = "tcp", description = "Public Access", cidr_blocks = "0.0.0.0/0" }]
}


# aws_iam_role


variable "tags" {
  type = map(any)
  default = {
    "env" = "dev"
  }
}

