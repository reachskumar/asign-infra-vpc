# Production environment variables

# Network
variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
  default     = "172.31.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "Public subnet CIDRs"
  type        = list(string)
  default     = ["172.31.10.0/24", "172.31.11.0/24"]
}

variable "private_subnet_cidrs" {
  description = "Private subnet CIDRs"
  type        = list(string)
  default     = ["172.31.20.0/24", "172.31.21.0/24"]
}

variable "availability_zones" {
  description = "Availability zones"
  type        = list(string)
  default     = ["ap-south-1a", "ap-south-1b"]
}

variable "enable_nat_gateway" {
  description = "Enable NAT gateway"
  type        = bool
  default     = true
}

variable "ssh_cidr_blocks" {
  description = "SSH access CIDRs"
  type        = list(string)
  default     = ["10.0.0.0/8", "172.16.0.0/12", "192.168.0.0/16"]
}

# Bastion
variable "bastion_instance_type" {
  description = "Bastion instance type"
  type        = string
  default     = "t3.small"
}

variable "bastion_volume_size" {
  description = "Bastion volume size (GB)"
  type        = number
  default     = 30
}

variable "bastion_ssh_cidr_blocks" {
  description = "Bastion SSH access CIDRs"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "key_pair_name" {
  description = "SSH key pair name"
  type        = string
  default     = "asign-bastion-key"
}

# Tags
variable "additional_tags" {
  description = "Additional tags"
  type        = map(string)
  default     = {}
}