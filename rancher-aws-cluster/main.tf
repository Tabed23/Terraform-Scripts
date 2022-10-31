#Configure the Provider
provider "aws" {

  region = var.region
}
provider "rke" {
  log_file = "rke_debug.log"
  debug    = true
}

#Configure STATE FILE TO STORE ON S3
terraform {
  backend "s3" {
    bucket = "stateterraformfolder"
    key    = "stateterraformfolder/terraform.tfstate"
    region = "us-east-2"
  }
}

#VPC module [cofigures in all Regions, "makes" : cidr, internet ,nat gateway, public, private subnet]
module "vpc" {
  source             = "./module/vpc"
  vpc_cidr           = var.cidr
  vpc_network_name   = var.vpc_network_name
  ig_gateway_name    = var.ig_gateway_name
  nat_gateway_name   = var.nat_gateway_name
  env                = var.env_type
  public_subnets     = var.public_subnets_cidr
  private_subnets    = var.private_subnets_cidr
  availability_zones = data.aws_availability_zones.available.names
}
module "cluster" {
  source               = "./module/cluster"
  instance_type        = var.instance_type
  public_subnet_id     = module.vpc.public_subnets[0].id
  private_subnet_id    = module.vpc.private_subnets[0].id
  ec2sg                = module.vpc.bastion_sg
  availability_zones   = data.aws_availability_zones.available.names[0]
  keyname              = var.keyname
  worker_instance_type = var.worker_instance_type
  no_of_worker_nodes   = var.no_of_worker_nodes
}

module "secrets-manager" {

  source = "lgallard/secrets-manager/aws"
  secrets = {
    cluster_pem = {
      description             = "private pem"
      recovery_window_in_days = 7
      secret_string           = module.cluster.tls_rsa_key
    },
  }

  tags = {
    Environment = var.env_type
  }
}

module "rke" {
  source = "./module/rke"

}