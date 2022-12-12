terraform {
  required_version = ">= 0.13"
  required_providers {
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
    bucket = "your bucket name"
    key    = "your bucket name/terraform.tfstate"
    region = "us-west-2"
  }
}


module "infra" {
  source             = "./module/infra"
  vpc_cidr           = var.cidr
  vpc_network_name   = var.vpc_network_name
  ig_gateway_name    = var.ig_gateway_name
  nat_gateway_name   = var.nat_gateway_name
  env                = var.env_type
  public_subnets     = var.public_subnets_cidr
  private_subnets    = var.private_subnets_cidr
  availability_zones = data.aws_availability_zones.available.names
  domain_name        = var.domain_name
  keyname            = var.keyname
  rds_sg             = module.eks.eks_cluster.vpc_config[0].cluster_security_group_id
  cluster_name       = "${var.env_type}-cluster"
}


module "aws_global" {
  source      = "./module/global"
  bucket_name = "bucket11"
  env_type    = var.env_type
}

#  module "rds" {
#   depends_on        = [module.infra]
#   source            = "./module/database"
#   env_type          = var.env_type
#   db_instance_class = var.db_instance_class
#   rds_username      = var.rds_username
#   rds_password      = var.rds_password
#   private_subnets   = module.infra.private_subnets
#   db-sg             = module.infra.sg
# }

# module "elasti_cache" {
#   depends_on            = [module.infra]
#   source                = "./module/cache"
#   env_type              = var.env_type
#   redis_node_type       = var.redis_node_type
#   redis_num_cache_nodes = var.redis_num_cache_nodes
#   redis_sg              = module.infra.sg
#   private_subnets       = module.infra.private_subnets
# }


module "eks" {
  depends_on       = [module.nginx_ec2]
  source           = "./module/k8s"
  cluster_name     = "${var.env_type}-cluster"
  k8sversion       = var.k8sversion
  cluster_role_arn = module.aws_global.eks_cluster_role
  nodes_role_arn   = module.aws_global.eks_nodes_role
  private_subnets  = module.infra.private_subnets
  node_group_name  = "${var.env_type}-node-group"
  env_type         = var.env_type
  keyname          = var.keyname
  sg               = module.infra.sg
  instance_type    = var.instance_type
}

module "bastion_host" {

  source             = "./module/aws"
  instance_type      = "t2.micro"
  public_subnet_id   = module.infra.public_subnets
  sg                 = module.infra.sg
  availability_zones = data.aws_availability_zones.available.names[0]
  private_key        = module.infra.privatekey
  key_name           = var.keyname
  region             = var.region
  cluster_name       = "${var.env_type}-cluster"
  instance_profile   = module.aws_global.instance_profile
}


module "nginx_ec2" {
  source             = "./module/nginx"
  ec2_instance_size  = "t2.micro"
  public_subnet_id   = module.infra.public_subnets
  sg                 = module.infra.sg
  availability_zones = data.aws_availability_zones.available.names[0]
  key_name           = var.keyname
  region             = var.region
  load_balancer_name = var.load_balancer_name
  instance_profile   = module.aws_global.instance_profile
  vpc_id             = module.infra.id
  target_group_name  = var.target_group_name
  private_key        = module.infra.privatekey
}

