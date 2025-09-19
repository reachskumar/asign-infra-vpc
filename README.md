# Asign Infrastructure

AWS VPC infrastructure with staging and production environments.


## Prerequisites

**Required versions:**
- Terraform v1.5.0+
- AWS CLI v2.13.0+
- AWS Provider v5.0+

**Tested with:**
- Terraform: v1.5.0+
- AWS CLI: v2.13.0+
- AWS Provider: v5.0+

**Setup:**
- AWS credentials configured
- SSH key pair (created during setup)

## Deploy

**Staging:**
cd tf/staging/vpc
terraform init
terraform plan
terraform apply

**Production:**
cd tf/production/vpc
terraform init
terraform plan
terraform apply

## Access

**Get bastion IP:**
terraform output bastion_eip

**SSH to bastion:**
ssh -i ~/.ssh/asign-bastion-key.pem ec2-user@<bastion-ip>

**From bastion:**
list-private-instances
ssh-private <instance-id>

## Networks

**Staging (ap-south-2):**
- VPC: 172.31.0.0/16
- Public: 172.31.30.0/24, 172.31.31.0/24
- Private: 172.31.40.0/24, 172.31.41.0/24
- Bastion: t3.micro

**Production (ap-south-1):**
- VPC: 172.31.0.0/16
- Public: 172.31.10.0/24, 172.31.11.0/24
- Private: 172.31.20.0/24, 172.31.21.0/24
- Bastion: t3.small

## Testing

cd tests/vpc
./validate.sh

## Configuration

**Restrict bastion access:**
Edit terraform.tfvars:
bastion_ssh_cidr_blocks = ["YOUR_IP/32"]

**Check resources:**
aws ec2 describe-vpcs --region ap-south-2 --filters "Name=tag:Project,Values=asign"
