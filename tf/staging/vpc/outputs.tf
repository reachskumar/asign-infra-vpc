# Staging outputs

# VPC
output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "vpc_cidr_block" {
  description = "VPC CIDR"
  value       = module.vpc.vpc_cidr_block
}

output "public_subnet_ids" {
  description = "Public subnet IDs"
  value       = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  description = "Private subnet IDs"
  value       = module.vpc.private_subnet_ids
}

output "internet_gateway_id" {
  description = "Internet gateway ID"
  value       = module.vpc.internet_gateway_id
}

output "nat_gateway_ids" {
  description = "NAT gateway IDs"
  value       = module.vpc.nat_gateway_ids
}

output "ssh_security_group_id" {
  description = "SSH security group ID"
  value       = module.vpc.ssh_security_group_id
}

# Bastion
output "bastion_instance_id" {
  description = "Bastion instance ID"
  value       = module.bastion.bastion_instance_id
}

output "bastion_public_ip" {
  description = "Bastion public IP"
  value       = module.bastion.bastion_public_ip
}

output "bastion_eip" {
  description = "Bastion Elastic IP"
  value       = module.bastion.bastion_eip
}

output "bastion_ssh_command" {
  description = "SSH command for bastion"
  value       = module.bastion.bastion_ssh_command
}