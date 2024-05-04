output "my-primary-ec2-public-ip" {
  value = module.primary_region.my-ec2-public-ip
}

output "my-secondary-ec2-public-ip" {
  value = module.secondary_region.my-ec2-public-ip
}

output "my-primary-ec2-private-ip" {
  value = module.primary_region.my-ec2-private-ip
}

output "my-secondary-ec2-private-ip" {
  value = module.secondary_region.my-ec2-private-ip
}
