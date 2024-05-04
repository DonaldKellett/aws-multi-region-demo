variable "primary_region" {
  type    = string
  default = "ap-east-1"
}

variable "secondary_region" {
  type    = string
  default = "ap-southeast-1"
}

variable "primary_vpc_cidr" {
  type    = string
  default = "10.1.0.0/16"
}

variable "secondary_vpc_cidr" {
  type    = string
  default = "10.2.0.0/16"
}