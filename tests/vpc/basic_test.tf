# VPC Module Basic Test

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Standard VPC test
module "test_vpc" {
  source = "../../tf/modules/vpc"
  
  project_name         = "test"
  environment          = "test"
  vpc_cidr             = "10.0.0.0/16"
  public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidrs = ["10.0.10.0/24", "10.0.20.0/24"]
  availability_zones   = ["us-west-2a", "us-west-2b"]
  
  tags = {
    Environment = "test"
    Project     = "test"
  }
}