# Staging VPC

terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "ap-south-2"
}

# Common values
locals {
  project_name = "asign"
  environment  = "staging"
  common_tags = merge(
    {
      Project     = local.project_name
      Environment = local.environment
      Owner       = "DevOps"
      Region      = "ap-south-2"
      ManagedBy   = "Terraform"
    },
    var.additional_tags
  )
}

# VPC
module "vpc" {
  source = "../../modules/vpc"

  project_name = local.project_name
  environment  = local.environment

  vpc_cidr = var.vpc_cidr

  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs

  availability_zones = var.availability_zones

  enable_nat_gateway = var.enable_nat_gateway
  ssh_cidr_blocks   = var.ssh_cidr_blocks

  tags = local.common_tags
}

# Bastion
module "bastion" {
  source = "../../modules/bastion"

  project_name         = local.project_name
  environment          = local.environment
  vpc_id               = module.vpc.vpc_id
  public_subnet_id     = module.vpc.public_subnet_ids[0]
  instance_type        = var.bastion_instance_type
  volume_size          = var.bastion_volume_size
  bastion_ssh_cidr_blocks = var.bastion_ssh_cidr_blocks
  create_key_pair      = false
  existing_key_name    = var.key_pair_name
  allocate_eip         = true

  tags = local.common_tags
}