provider "aws" {
  region = var.primary_region
  alias  = "primary_region"
}

provider "aws" {
  region = var.secondary_region
  alias  = "secondary_region"
}

module "primary_region" {
  source         = "./multi-region-module"
  vpc_cidr_block = var.primary_vpc_cidr
  providers = {
    aws = aws.primary_region
  }
}

module "secondary_region" {
  source         = "./multi-region-module"
  vpc_cidr_block = var.secondary_vpc_cidr
  providers = {
    aws = aws.secondary_region
  }
}
