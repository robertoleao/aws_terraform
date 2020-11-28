# Configura uma gateway para a vpc
resource "aws_internet_gateway" "My_VPC_GW" {
 vpc_id = aws_vpc.My_VPC.id
 tags = {
        Name = "Internet Gateway"
  }
}