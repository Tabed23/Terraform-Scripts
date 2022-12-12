
variable "keyname" {}

variable "public_subnet_id" {}

variable "sg" {}

variable "bastion_instance_type" {}

variable "availability_zones" {}

variable "private_key" {}
variable "region" {}

variable "access_key" {
  type = string
}


variable "secret_key" {
  type = string
}

variable "cluster_name" {}