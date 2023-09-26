
resource "aws_vpc" "NYDC_VPC" {
  cidr_block = "10.92.0.0/16"
  enable_dns_hostname = true
  enable_dns_support = true

  tags = {
    Name = "DEV_VPC"
  }
}

resource "aws_subnet" "NYDC_Subnet" {
  cidr_block = "10.92.1.0/24"
   vpc_id     = aws_vpc.NYDC_VPC.id
  map_public_ip_on_lunch = true
  availability_zone = "us-east-1"
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

resource "aws_security_group" "aws_sec" {
  vpc_id = aws_vpc.NYDC_VPC.id
  name = "nydc_sec_grp"
  description = "allow_ssh_inbound"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [""]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}



resource "aws_eip" "aws_IP" {
  vpc = true
}







