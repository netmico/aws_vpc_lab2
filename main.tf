provider "aws" {
  region = var.aws_region
}

terraform {
  backend "s3" {
    bucket  = "s3-dev11"
    key     = "aws_vpc/dev/terraform.tf"
    region  = "us-east-1"
    encrypt = true
  }
}

resource "aws_vpc" "NYDC_VPC" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = var.NYDC_VPC
  }
}

resource "aws_subnet" "NYDC_Subnet" {
  count      = length(var.subnet_cidrs)
  cidr_block = var.subnet_cidrs[count.index]
  vpc_id     = aws_vpc.NYDC_VPC.id
}