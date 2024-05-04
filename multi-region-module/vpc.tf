resource "aws_vpc" "my-vpc" {
  cidr_block = var.vpc_cidr_block
}

resource "aws_internet_gateway" "my-igw" {
  vpc_id = aws_vpc.my-vpc.id
}

resource "aws_subnet" "my-subnet" {
  vpc_id     = aws_vpc.my-vpc.id
  cidr_block = var.subnet_cidr_block
}

resource "aws_route_table" "my-rtb" {
  vpc_id = aws_vpc.my-vpc.id
}

resource "aws_route" "my-igw-route" {
  route_table_id         = aws_route_table.my-rtb.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.my-igw.id
}

resource "aws_route_table_association" "my-rtb-association" {
  route_table_id = aws_route_table.my-rtb.id
  subnet_id      = aws_subnet.my-subnet.id
}
