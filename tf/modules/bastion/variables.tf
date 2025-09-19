# Bastion module variables

variable "project_name" {
  description = "Project name"
  type        = string
}

variable "environment" {
  description = "Environment (staging, production)"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "public_subnet_id" {
  description = "Public subnet ID for bastion"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "volume_size" {
  description = "Root volume size (GB)"
  type        = number
  default     = 20
}

variable "bastion_ssh_cidr_blocks" {
  description = "CIDR blocks for bastion SSH access"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "create_key_pair" {
  description = "Create new key pair"
  type        = bool
  default     = true
}

variable "existing_key_name" {
  description = "Existing key pair name"
  type        = string
  default     = null
}

variable "allocate_eip" {
  description = "Allocate Elastic IP"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Resource tags"
  type        = map(string)
  default     = {}
}