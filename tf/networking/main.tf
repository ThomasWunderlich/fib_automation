data "aws_availability_zones" "available" {}

locals {
  azs      = slice(data.aws_availability_zones.available.names, 0, 3)

  tags = {
    Terraform = "true"
    Environment = "dev"
    Service = "Fibonacci"
  }
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "fibbonaci"
  cidr = var.vpc_cidr

  azs             = local.azs
  private_subnets = [for k, v in local.azs : cidrsubnet(var.vpc_cidr, 8, k)]
  public_subnets  = [for k, v in local.azs : cidrsubnet(var.vpc_cidr, 8, k + 4)]

  # turn on only 1 nat gateway, since this is a POC
  enable_nat_gateway = true
  single_nat_gateway = true
  one_nat_gateway_per_az = false
  enable_vpn_gateway = false

  tags = local.tags
}