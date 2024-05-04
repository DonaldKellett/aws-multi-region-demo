output "my-ec2-public-ip" {
  value = aws_instance.my-ec2-instance.public_ip
}

output "my-ec2-private-ip" {
  value = aws_instance.my-ec2-instance.private_ip
}

output "my-vpc-id" {
  value = aws_vpc.my-vpc.id
}
