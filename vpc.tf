resource "aws_vpc_peering_connection" "vpc-peer-requester" {
  provider = aws.primary_region

  vpc_id      = module.primary_region.my-vpc-id
  peer_vpc_id = module.secondary_region.my-vpc-id
  peer_region = var.secondary_region
  auto_accept = false
}

resource "aws_vpc_peering_connection_accepter" "vpc-peer-accepter" {
  provider = aws.secondary_region

  vpc_peering_connection_id = aws_vpc_peering_connection.vpc-peer-requester.id
  auto_accept               = true
}

resource "aws_vpc_peering_connection_options" "vpc-peer-requester-options" {
  provider = aws.primary_region

  vpc_peering_connection_id = aws_vpc_peering_connection_accepter.vpc-peer-accepter.id

  requester {}
}

resource "aws_vpc_peering_connection_options" "vpc-peer-accepter-options" {
  provider = aws.secondary_region

  vpc_peering_connection_id = aws_vpc_peering_connection_accepter.vpc-peer-accepter.id

  accepter {}
}
