terraform {
  required_version = ">= 0.13"
  required_providers {
    rancher2 = {
      source  = "rancher/rancher2"
      version = "1.24.2"
    }
    rke = {
      source  = "rancher/rke"
      version = "1.3.4"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "4.38.0"
    }
  }
}

provider "aws" {

  region = var.region
}



terraform {
  backend "s3" {
    bucket = "rke-tf-state"
    key    = "rke-tf-state/terraform.tfstate"
    region = "us-east-2"
  }
}

module "infrastructure" {
  source             = "./module/infrastructure"
  vpc_cidr           = var.cidr
  vpc_network_name   = var.vpc_network_name
  ig_gateway_name    = var.ig_gateway_name
  nat_gateway_name   = var.nat_gateway_name
  env                = var.env_type
  public_subnets     = var.public_subnets_cidr
  private_subnets    = var.private_subnets_cidr
  availability_zones = data.aws_availability_zones.available.names
  domain_name        = var.domain_name
  zone_id            = var.zone_id

}

module "rancher-ui" {
  source             = "./module/rancher/aws"
  instance_type      = var.rancher_instance_type
  public_subnet_id   = module.infrastructure.public_subnets
  sg                 = module.infrastructure.sg
  availability_zones = data.aws_availability_zones.available.names[0]
  key_name           = var.keyname
}

module "global-cluster" {
  source             = "./module/global/aws"
  zone_id            = var.zone_id
  rancher_domain     = var.rancher_domain
  keyname            = var.keyname
  vpc_id             = module.infrastructure.id
  public_subnet_id   = module.infrastructure.public_subnets
  private_subnet_id  = module.infrastructure.public_subnets
  target_group_name  = var.target_group_name
  load_balancer_name = var.load_balancer_name
  sg                 = module.infrastructure.sg
  rancher_server     = module.rancher-ui.rancher_server
  instance_ip        = module.rancher-ui.rancher_host_ip
  domain_name        = var.domain_name
  cert               = module.infrastructure.aws_certificate
  instance_type      = var.instance_type
  no_of_worker_nodes = var.no_of_worker_nodes
  availability_zones = data.aws_availability_zones.available.names[0]
}