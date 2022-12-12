variable "ig_gateway_name" {}

variable "nat_gateway_name" {}

variable "vpc_network_name" {}

variable "vpc_cidr" {
  type = string
}


variable "public_subnets" {
  type = list(string)
}

variable "availability_zones" {
  type = list(string)
}

variable "private_subnets" {
  type = list(string)
}
variable "env" {}


variable "cluster_name" {}
