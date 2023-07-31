variable "aws_region" {
  description = "aws_prefered region"
  default     = "us-east-1"
}

variable "NYDC_VPC" {
  description = "Name of the VPC in NYDC"
  default     = "NYDC_VPC"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC."
  default     = "10.92.0.0/16"
}

variable "subnet_cidrs" {
  type    = list(string)
  default = ["10.92.1.0/24", "10.92.2.0/24", "10.92.3.0/24"]
}