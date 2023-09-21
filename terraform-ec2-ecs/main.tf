terraform {
  required_version = ">= 0.12"
  backend "s3" {
    bucket     = "terraform-mybucket-ecs1"
    key        = "my/app/state.tfstate"
    region     = "us-east-2"
    access_key = ""
    secret_key = ""

  }
}

provider "aws" {
  region = var.region

}

module "vpc" {
  source                 = "./module/vpc"
  vpc_cidr               = var.vpc_cidr
  name                   = var.name
  env                    = var.env
  public_subnets_cidr    = var.public_subnets_cidr
  private_subnets_cidr   = var.private_subnets_cidr
  availability_zones     = data.aws_availability_zones.available.names
  name_of_security_group = "ssh-http"

}

/* module "ec2" {
  source="./module/ec2-instance"
  instance_type = "t2.micro"
  subnet_id =  module.vpc.public_subnets[0].id
  ec2sg= module.vpc.sg
  availability_zones= data.aws_availability_zones.available.names[0]
  name_of_instance="new-instance"
  keyname="newkey"
  keyfile=var.keyfile
  env=var.env


}  */

module "ecs" {
  source = "./module/ecs"
  vpc_id = module.vpc.vpc_id
  #---------------------ECR------------------- 
  ecr_repo_name = var.ecr_repo_name
  #------------LOAD BALANCER AND TARGET GROUP---------
  loadbalancer_sg    = module.vpc.loadbalancer_sg
  public_subnets     = module.vpc.public_subnets
  target_group_name  = var.target_group_name
  load_balancer_name = var.load_balancer_name
  #-----------TASK DEFINITION-------------------
  task_definition_name = var.task_definition_name
  containername        = var.containername
  container_port       = var.container_port
  host_port            = var.host_port
  td_memory            = var.td_memory
  td_cpu               = var.td_cpu
  container_memory     = var.container_memory
  container_cpu        = var.container_cpu
  #---------------------ECS CLUSTER & SERVICE--------------
  ecs_cluster_name = var.ecs_cluster_name
  ecs_service_name = var.ecs_service_name
  ECS_sg           = module.vpc.ECS_sg
  private_subnets  = module.vpc.private_subnets
}


