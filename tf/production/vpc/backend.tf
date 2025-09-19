terraform {
  backend "s3" {
    bucket         = "asign-terraform-state-bucket"
    key            = "environments/production/vpc/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "asign-terraform-state-lock"
    encrypt        = true
  }
}
