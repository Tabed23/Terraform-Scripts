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
  type = string
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

variable "keyname" {}
variable "instance_type" {
  type = string
}


variable "worker_instance_type" {}

variable "no_of_worker_nodes" {}


#____________________TARGET GROUP AND LOAD BALANCER---



variable "target_group_name" {}

variable "load_balancer_name" {}

variable "domain_name" {}


variable "k8version" {
  default = "v1.15.5-rancher1-1"
}

variable "ssh_username" {
  type = string
  default = "ubuntu"
}

variable "private_key" {
  type = string
  default = "private_key.pem"
}


variable "cluster_name" {
  type = string
  default = "rks_cluste"
}