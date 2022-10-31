#Configure the AWS Provider
provider "aws" {
  region = var.region
}

#Configure STATE FILE TO STORE ON S3
terraform {
  backend "s3" {
    bucket = "stateterraformfolder1"
    key    = "stateterraformfolder/terraform.tfstate"
    region = "us-east-2"
  }
}
#VPC module [cofigures in all Regions, "makes" : cidr, internet ,nat gateway, public, private subnet]
module "vpc" {
  source               = "./module/vpc"
  vpc_cidr             = var.cidr
  vpc_network_name     = var.vpc_network_name
  ig_gateway_name      = var.ig_gateway_name
  nat_gateway_name     = var.nat_gateway_name
  env                  = var.env_type
  public_subnets       = var.public_subnets_cidr
  private_subnets      = var.private_subnets_cidr
  availability_zones   = data.aws_availability_zones.available.names
}
module "cluster" {
  source               = "./module/cluster"
  instance_type        =  var.instance_type
  subnet_id            =  module.vpc.public_subnets[0].id
  ec2sg                =  module.vpc.sg
  availability_zones   =  data.aws_availability_zones.available.names[0]
  keyname              =  var.keyname
  keyfile              =  var.keyfile
}

