#!/bin/bash

# VPC Module Validation
# Validates Terraform configuration and plans

set -e

echo "Validating VPC module..."

# Check we're in the right directory
if [ ! -f "basic_test.tf" ]; then
    echo "Error: Run from tests/vpc directory"
    exit 1
fi

# Initialize and validate
terraform init
terraform validate
terraform plan

echo "VPC module validation completed successfully"