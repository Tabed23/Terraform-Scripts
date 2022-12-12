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


variable "private_subnets_cidr" {
  type = list(string)
}

variable "instance_type" {
  type = string
}

variable "keyname" {}

variable "worker_instance_type" {}

variable "no_of_worker_nodes" {}

variable "domain_name" {}

# database
variable "db_instance_class" {}

variable "rds_username" {}
variable "rds_password" {}

# cache
variable "redis_node_type" {}
variable "redis_num_cache_nodes" {}

#EKS

variable "k8sversion" {}


variable "private_key" {
  type    = string
  default = "private_key.pem"
}

variable "load_balancer_name" {}

variable "target_group_name" {}
