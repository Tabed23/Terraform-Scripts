data "aws_ami" "ubuntu" {

  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}
# Get the availability_zones
data "aws_availability_zones" "available" {
  state = "available"
}
#Show the availability_zones
output "availability_zones" {
  value = data.aws_availability_zones.available.names
}
# Show the vpc public subnets
output "vpc_public_subnets" {
  value = module.vpc.public_subnets
}
# Show the vpc private subnets
output "vpc_private_subnets" {
  value = module.vpc.private_subnets
}
# Show the vpc id
output "vpc_id" {
  value = module.vpc.id
}
# Show the bastion host security group
output "sg" {
  value = module.vpc.bastion_sg
}

output "environment" {
  value = var.env_type
}

output "secret_manager" {
  value = module.secrets-manager.secret_arns.secret-key
}

output "region" {
  value = var.region
}
output "private_key" {
  sensitive = true
  value     = module.cluster.privatekey
}

output "alb" {
  value = module.cluster.alb
}

# output "acm_cert" {
#   value     = module.vpc.acm_cert
#   sensitive = true
# }


output "bastion_ip" {
  value = module.cluster.bastion_host_ip
}


output "rancher_instance" {
  value = module.cluster.rancher_instance_ip
}


output "rancher_domain" {
  value = module.cluster.domain_record
}