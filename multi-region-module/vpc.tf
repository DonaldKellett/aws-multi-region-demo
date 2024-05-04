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

resource "aws_route" "my-vpc-peer-route" {
  route_table_id            = aws_route_table.my-rtb.id
  destination_cidr_block    = var.peer_vpc_cidr
  vpc_peering_connection_id = var.vpc_peering_connection_id
}

resource "aws_route_table_association" "my-rtb-association" {
  route_table_id = aws_route_table.my-rtb.id
  subnet_id      = aws_subnet.my-subnet.id
}

resource "aws_security_group" "my-sg" {
  name        = "my-sg"
  description = "My security group"
  vpc_id      = aws_vpc.my-vpc.id
}

resource "aws_security_group_rule" "my-sg-ingress-0" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.my-sg.id
}

resource "aws_security_group_rule" "my-sg-ingress-1" {
  type              = "ingress"
  from_port         = -1
  to_port           = -1
  protocol          = "icmp"
  cidr_blocks       = [var.peer_vpc_cidr]
  security_group_id = aws_security_group.my-sg.id
}

resource "aws_security_group_rule" "my-sg-egress-0" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.my-sg.id
}
