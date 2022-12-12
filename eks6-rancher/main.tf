terraform {
  required_version = ">= 0.13"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.38.0"
    }
    time = {
      source  = "hashicorp/time"
      version = "0.9.1"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.7.1"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.15.0"
    }
  }
}

provider "aws" {
  region = var.region
}

provider "time" {

}
terraform {
  backend "s3" {
    bucket = "rancher-eks-01"
    key    = "rancher-eks-01/terraform.tfstate"
    region = "us-east-1"
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
  cluster_name       = var.cluster_name

}

module "gloabl" {
  depends_on = [module.infrastructure]
  source     = "./module/global/aws"
  keyname    = var.keyname
}

module "eks_cluster" {
  source             = "./module/rancher/aws"
  k8sversion         = var.k8sversion
  cluster_role_arn   = module.gloabl.eks_cluster_role
  nodes_role_arn     = module.gloabl.eks_nodes_role
  env_type           = var.env_type
  private_subnets    = module.infrastructure.private_subnets
  cluster_name       = var.cluster_name
  instance_type      = var.worker_instance_type
  no_of_worker_nodes = var.no_of_worker_nodes
  node_group_name    = var.node_group_name
  private_key        = module.gloabl.privatekey
  sg                 = module.infrastructure.sg
  region             = var.region
}

module "bastion_host" {
  depends_on            = [module.eks_cluster]
  source                = "./module/global/bastion"
  bastion_instance_type = var.bastion_instance_type
  public_subnet_id      = module.infrastructure.public_subnets
  sg                    = module.infrastructure.sg
  availability_zones    = data.aws_availability_zones.available.names[0]
  keyname               = var.keyname
  private_key           = module.gloabl.privatekey
  region                = var.region
  cluster_name          = var.cluster_name
  access_key            = var.access_key
  secret_key            = var.secret_key
}
provider "helm" {
  kubernetes {
    host                   = module.eks_cluster.eks_endpint
    cluster_ca_certificate = base64decode(module.eks_cluster.kubeconfig-certificate-authority-data)
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["eks", "get-token", "--cluster-name", var.cluster_name]
      command     = "aws"
    }
  }
}
provider "kubernetes" {
  host                   = module.eks_cluster.eks_endpint
  cluster_ca_certificate = base64decode(module.eks_cluster.kubeconfig-certificate-authority-data)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["eks", "get-token", "--cluster-name", var.cluster_name]
    command     = "aws"
  }
}

module "rancher" {
  depends_on = [
    module.bastion_host
  ]
  source  = "./module/rancher/helm"
  zone_id = var.zone_id
}