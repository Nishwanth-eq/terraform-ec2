module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.0.0"

  name = "login-app-vpc"
  cidr = var.vpc_cidr

  azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets

  enable_nat_gateway = true
  single_nat_gateway = false
}
