variable "instance_type" {
  type = string
}

variable "private_subnet_id" {}

variable "public_subnet_id" {}

variable "ec2sg" {}

variable "availability_zones" {}

variable "keyname" {}

variable "local_public_key" {}

variable "worker_instance_type" {}

variable "no_of_worker_nodes" {}
