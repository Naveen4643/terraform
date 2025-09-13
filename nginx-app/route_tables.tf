#Public Route Table
resource "aws_route_table" "public-rt" {
    vpc_id           = aws_vpc.myvpc.id
    tags = {
      Name = "public_rt"
    }
}

#Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id          = aws_vpc.myvpc.id
  tags = {
    Name = "igw-myvpc"
  }

}

#public Route
resource "aws_route" "public-route" {
    route_table_id = aws_route_table.public-rt.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id             = aws_internet_gateway.igw.id
}

#public Route Table Association
resource "aws_route_table_association" "public-rt-assoc" {
    subnet_id      = aws_subnet.public-subnet-1.id
    route_table_id = aws_route_table.public-rt.id
}


#Elastic IP
resource "aws_eip" "nat-eip" {
    #vpc = true
    tags = {
      Name = "nat-eip"
    }
}


#Nat Gateway
resource "aws_nat_gateway" "nat-gw" {
    tags = {
      Name = "my-nat-gw"
    }
    subnet_id = aws_subnet.private-subnet-1.id
    allocation_id = aws_eip.nat-eip.id
}

#private Route Table
resource "aws_route_table" "private-rt" {
    vpc_id           = aws_vpc.myvpc.id
    tags = {
      Name = "private-rt"
    }
}

#private Route
resource "aws_route" "name" {
  route_table_id         = aws_route_table.private-rt.id
  destination_cidr_block =  "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat-gw.id

}

#private Route Table Association
resource "aws_route_table_association" "private-rt-assoc" {
    subnet_id      = aws_subnet.private-subnet-1.id
    route_table_id = aws_route_table.private-rt.id
}