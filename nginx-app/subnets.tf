#Public Subnet
resource "aws_subnet" "public-subnet-1" {
    vpc_id              = aws_vpc.myvpc.id
    cidr_block          = var.public_subnet_1_cidr
    availability_zone   = "var.aws_region_a"
    map_public_ip_on_launch = true
    tags = {
        Name = var.public_subnet_1_name
    }
}

#Private Subnet
resource "aws_subnet" "private-subnet-1" {
    vpc_id                 = aws_vpc.myvpc.id
    cidr_block             = var.private_subnet_1_cidr
    availability_zone      = "var.aws_region_a"
    tags = {
      Name = var.private_subnet_1_name
    }
}