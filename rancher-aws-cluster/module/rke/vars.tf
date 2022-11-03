variable "k8version" {
  default = "v1.15.5-rancher1-1"
}

variable "bastion_address" {}

variable "ssh_username" {
  type = string
  default = "ubuntu"
}

variable "private_key" {
  type = string
  default = "private_key.pem"
}

variable "master_ip" {}

variable "woker_node_ip" {}