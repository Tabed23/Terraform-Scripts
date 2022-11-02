variable "instance_type" {
  type = string
}

variable "private_subnet_id" {}

variable "public_subnet_id" {}

variable "ec2sg" {}

variable "availability_zones" {}

variable "keyname" {}

variable "region" {}

variable "worker_instance_type" {}

variable "no_of_worker_nodes" {}

variable "secret_manager_arn" {}

variable "privatekey" {}

variable "vpc_id" {}

variable "target_group_name" {}

variable "load_balancer_name" {}