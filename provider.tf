terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}
terraform {
  backend "s3" {
    bucket  = "s3-dev11"
    key     = "aws_terrafrom/dev/terraform.tf"
    region  = "us-east-1"
    encrypt = true
  }
}
