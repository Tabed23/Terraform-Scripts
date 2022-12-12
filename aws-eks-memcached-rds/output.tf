# Get the availability_zones
data "aws_availability_zones" "available" {
  state = "available"
}

output "private_subnets" {
  value = module.infra.private_subnets[*].id
}

output "zones" {
  value = data.aws_availability_zones.available.names
}

output "sg" {
  value = module.infra.sg.id
}