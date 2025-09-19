# VPC Module Edge Cases

# Minimal configuration
module "test_vpc_minimal" {
  source = "../../tf/modules/vpc"
  
  project_name         = "test-min"
  environment          = "test"
  vpc_cidr             = "172.16.0.0/16"
  public_subnet_cidrs  = ["172.16.1.0/24", "172.16.2.0/24"]
  private_subnet_cidrs = ["172.16.10.0/24", "172.16.20.0/24"]
  availability_zones   = ["us-west-2a", "us-west-2b"]
  
  tags = {
    Environment = "test"
  }
}

# No NAT gateway
module "test_vpc_no_nat" {
  source = "../../tf/modules/vpc"
  
  project_name         = "test-no-nat"
  environment          = "test"
  vpc_cidr             = "192.168.0.0/16"
  public_subnet_cidrs  = ["192.168.1.0/24", "192.168.2.0/24"]
  private_subnet_cidrs = ["192.168.10.0/24", "192.168.20.0/24"]
  availability_zones   = ["us-west-2a", "us-west-2b"]
  enable_nat_gateway   = false
  
  tags = {
    Environment = "test"
  }
}