resource "aws_subnet" "My_VPC_Subnet" {
  vpc_id                  = aws_vpc.My_VPC.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
tags = {
   Name = "VPC Subnet"
  }
}