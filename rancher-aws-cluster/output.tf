data "aws_availability_zones" "available" {
  state = "available"
}

output "availability_zones" {
  value = data.aws_availability_zones.available.names
}


output "vpc_public_subnets" {
  value = module.vpc.public_subnets
}

output "vpc_private_subnets" {
  value = module.vpc.private_subnets
}

output "vpc_id" {
  value = module.vpc.id
}


 output "sg" {
    value= "${module.vpc.sg}"
} 