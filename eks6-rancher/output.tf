# Get the availability_zones
data "aws_availability_zones" "available" {
  state = "available"
}

output "vpc_id" {
  value = module.infrastructure.id
}

output "private_subnets" {
  value = module.infrastructure.private_subnets[*].id
}


output "public_subnets" {
  value = module.infrastructure.public_subnets[*].id
}

output "eks_endpoint" {
  value = module.eks_cluster.eks_endpint
}

output "kubeconfig-certificate-authority-data" {
  value = module.eks_cluster.kubeconfig-certificate-authority-data
}

# output "lb_name" {
#   value = module.rancher.alb_name
# }