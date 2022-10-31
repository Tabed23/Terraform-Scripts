variable "instance_type" {
  type = string
}

variable "private_subnet_id" {}
variable "public_subnet_id" {}
variable "ec2sg" {}
variable "availability_zones" {}
variable "keyname" {}
variable "keyfile" {}
variable "worker_instance_type" {}
#variable "no_of_worker_nodes" {}