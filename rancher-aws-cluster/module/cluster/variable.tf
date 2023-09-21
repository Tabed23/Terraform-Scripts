variable "instance_type" {
  type = string
}

variable "private_subnet_id" {}

variable "public_subnet_id" {}

variable "ec2sg" {}

variable "availability_zones" {}

variable "keyname" {}

variable "region" {}

variable "rancher_instance_type" {}
variable "no_of_worker_nodes" {}

variable "secret_manager_arn" {}

variable "privatekey" {}

variable "vpc_id" {}

variable "target_group_name" {}

variable "load_balancer_name" {}

variable "domain_name" {}

variable "zone_id" {
  type    = string
  default = "your aws zone id"
}

variable "rancher_domain" {
  type    = string
  default = "your aws rancher domain"
}