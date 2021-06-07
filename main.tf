provider "aws" {
  region = "eu-central-1"
}

locals {
  common_tags = {
    Purpose = "For education"
    Project = "Mini project Hillel"
  }
}

module "vpc" {
  source   = "./modules/vpc"
  vpc_cidr = "10.0.0.0/16"
  tags     = local.common_tags
}

module "ec2" {
  source         = "./modules/ec2"
  instance_count = "2"
  instance_type  = "t2.micro"
  ami            = "ami-043097594a7df80ec"
  ssh_key        = var.ssh_key
  eip_attach     = true
  vpc_subnets    = module.vpc.public_networks[1]
  vpc_id         = module.vpc.vpc_id
  ebs_size       = "8"
  tags           = local.common_tags
}