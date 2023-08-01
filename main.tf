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

resource "aws_vpc" "NYDC_VPC" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = var.NYDC_VPC
  }
}

resource "aws_subnet" "NYDC_Subnet" {
  cidr_block = "10.92.1.0/24"
  vpc_id     = aws_vpc.NYDC_VPC.id
}

resource "aws_internet_gateway" "nydc_igw" {
  vpc_id = aws_vpc.NYDC_VPC.id
}
resource "aws_route_table" "aws_rt" {
  vpc_id = aws_vpc.NYDC_VPC.id
}
resource "aws_route" "default_rt" {
  route_table_id         = aws_route_table.aws_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.nydc_igw.id
}

resource "aws_route_table_association" "nydc_assoc" {
  subnet_id      = aws_subnet.NYDC_Subnet.id
  route_table_id = aws_route_table.aws_rt.id

}

