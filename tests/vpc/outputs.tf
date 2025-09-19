# Test outputs

output "test_vpc_id" {
  description = "Basic test VPC ID"
  value       = module.test_vpc.vpc_id
}

output "test_vpc_public_subnets" {
  description = "Basic test public subnets"
  value       = module.test_vpc.public_subnet_ids
}

output "test_vpc_private_subnets" {
  description = "Basic test private subnets"
  value       = module.test_vpc.private_subnet_ids
}

output "test_vpc_minimal_id" {
  description = "Minimal test VPC ID"
  value       = module.test_vpc_minimal.vpc_id
}

output "test_vpc_no_nat_id" {
  description = "No NAT test VPC ID"
  value       = module.test_vpc_no_nat.vpc_id
}