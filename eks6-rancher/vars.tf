variable "access_key" {
  type    = string
  default = ""
}

variable "secret_key" {
  type    = string
  default = ""
}

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


variable "worker_instance_type" {}

variable "no_of_worker_nodes" {}


variable "cluster_name" {
  type    = string
  default = "rancher-cluster"
}

variable "bastion_instance_type" {}
variable "k8sversion" {}

variable "node_group_name" {}


variable "zone_id" {}
