provider "aws" {
  region = "us-east-1"
}
terraform {
  backend "s3" {
    bucket = "modi-test-tf"
    key = "devops-experts/demo/backend/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "terraform-up-and-running-locks"
  }
}
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-2.0.20210813.1-x86_64-gp2"]
  }
}