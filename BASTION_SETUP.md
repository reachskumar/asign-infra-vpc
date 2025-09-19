# Bastion Setup

SSH gateway for private server access.

## Prerequisites

**Required versions:**
- Terraform v1.5.0+
- AWS CLI v2.13.0+
- AWS Provider v5.0+

**Tested with:**
- Terraform: v1.5.0+
- AWS CLI: v2.13.0+
- AWS Provider: v5.0+

## Setup

**1. Create SSH key:**
ssh-keygen -t rsa -b 4096 -f ~/.ssh/asign-bastion-key
aws ec2 import-key-pair --key-name "asign-bastion-key" --public-key-material fileb://~/.ssh/asign-bastion-key.pub

**2. Deploy:**
cd tf/staging/vpc    # or tf/production/vpc
terraform init
terraform plan
terraform apply

**3. Get IP:**
terraform output bastion_eip

## Usage

**Connect:**
ssh -i ~/.ssh/asign-bastion-key.pem ec2-user@<bastion-ip>

**Commands:**
- list-private-instances
- ssh-private <instance-id>

## Security

**Restrict access:**
Edit terraform.tfvars:
bastion_ssh_cidr_blocks = ["YOUR_IP/32"]

## Troubleshoot

**Can't connect:**
- Check security group allows your IP
- Verify key exists in AWS
- Check bastion is running

**Check resources:**
aws ec2 describe-instances --region ap-south-2 --filters "Name=tag:Project,Values=asign"