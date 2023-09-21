terraform {
  required_version = ">= 0.13"
  required_providers {
    rancher2 = {
      source  = "rancher/rancher2"
      version = "1.24.2"
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
    bucket = "newrke-cluster-sg12"
    key    = "rke-tf-state/terraform.tfstate"
    region = "us-west-2"
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
  depends_on         = [module.infrastructure]
  source             = "./module/rancher/aws"
  instance_type      = var.rancher_instance_type
  public_subnet_id   = module.infrastructure.public_subnets
  sg                 = module.infrastructure.sg
  availability_zones = data.aws_availability_zones.available.names[0]
  key_name           = var.keyname
  ig                 = module.infrastructure.ig
  keypair_dependent  = module.global-cluster.aws_keypair
}

module "global-cluster" {
  depends_on            = [module.infrastructure]
  source                = "./module/global/aws"
  zone_id               = var.zone_id
  rancher_domain        = var.rancher_domain
  keyname               = var.keyname
  vpc_id                = module.infrastructure.id
  public_subnet_id      = module.infrastructure.public_subnets
  sg                    = module.infrastructure.sg
  rancher_server        = module.rancher-ui.rancher_server
  rancher_instance_ip   = module.rancher-ui.rancher_host_ip
  domain_name           = var.domain_name
  bastion_instance_type = var.bastion_instance_type
  availability_zones    = data.aws_availability_zones.available.names[0]
  private_key_path      = var.private_key_path
  ig                    = module.infrastructure.ig


}

