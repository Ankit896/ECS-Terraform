module "network" {
  source                              = "./ot-er-ecs-role/network/"
  vpc_cidr_block                      = var.vpc_cidr_block
  vpc_name                            = var.vpc_name
  aws_public_subnet_cidr_blocks       = var.aws_public_subnet_cidr_blocks
  aws_subnet_availability_zone        = var.aws_subnet_availability_zone
  aws_private_subnet_cidr_blocks      = var.aws_private_subnet_cidr_blocks
  security_group_name                 = var.security_group_name
  eks_security_group_with_cidr_blocks = var.eks_security_group_with_cidr_blocks

}

module "aws_iam_role" {
  source = "./ot-er-ecs-role/role/"

}

module "aws_asg_alb" {
  source               = "./ot-er-ecs-role/asg_alb/"
  vpc_id               = module.network.vpc
  public_subnet_id     = module.network.public_subnet
  iam_instance_profile = module.aws_iam_role.aws_iam_instance_profile_ouput.arn
  key_name             = "myverginias"
  tags                 = var.tags
}

module "ecs" {
  source                 = "./ot-er-ecs-role/ecs"
  auto_scaling_group_arn = module.aws_asg_alb.aws_autoscaling_group_output.arn
  cluster_name           = "mycluster"
  tags                   = var.tags
  target_group_arn       = module.aws_asg_alb.aws_lb_target_group_output.arn

}