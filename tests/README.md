# VPC Tests

Basic validation tests for VPC module.

## Structure

tests/vpc/
├── basic_test.tf    # Standard VPC test
├── edge_cases.tf    # Minimal and no-NAT tests
├── outputs.tf       # Test outputs
└── validate.sh      # Validation script

## Running

cd tests/vpc
./validate.sh

Or manually:
terraform init
terraform validate
terraform plan

## Coverage

- VPC with public/private subnets
- NAT gateway configuration
- Multi-AZ deployment
- Minimal configuration
- No NAT gateway scenario