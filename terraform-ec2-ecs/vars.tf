  variable "region" {
  type    = string
  default = "us-east-2"
} 

variable "vpc_cidr" {
  type = string
}

variable "name" {
  type = string
}

variable "env" {
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

variable "keyfile" {}

#---------------------------------------------------------------------
#ECS

#---------------------ECR--------------------
variable "ecr_repo_name" {}

#---------------------TASK DEFINITION----------
variable "task_definition_name" {}
variable "containername" {}
variable "container_port" {}
variable "host_port" {}
variable "td_cpu" {}
variable "td_memory" {}
variable "container_memory" {}
variable "container_cpu" {} 

#---------------------LOAD BALANCER & TARGET GROUP-----------
variable "target_group_name" {}
variable "load_balancer_name" {}

#-------------------------------ECS SERVICE & CLUSTER------------
variable "ecs_cluster_name" {}
variable "ecs_service_name" {}