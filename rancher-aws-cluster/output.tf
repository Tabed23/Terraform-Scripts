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
  value= module.secrets-manager.secret_arns
}

output "region" {
  value = var.region
}