variable "ig_gateway_name" {}

variable "nat_gateway_name" {}

variable "vpc_network_name" {}

variable "region" {
  type = string
}

variable "cidr" {
  type = string
}

variable "env_type" {
  type    = string
}

variable "public_subnets_cidr" {
  type = list(string)
}

/* variable "availability_zones" {
  type = list(string)
} */

variable "private_subnets_cidr" {
  type = list(string)
}


variable "instance_type" {
  type = string
}

variable "keyname" {}
variable "keyfile" {}