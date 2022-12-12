resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr

  enable_dns_support               = true
  enable_dns_hostnames             = true
  instance_tenancy                 = "default" # Make your instance share host
  assign_generated_ipv6_cidr_block = false     # Requests an Amazon-provided IPv6 CIDR block with a /56 prefix length for the VPC.


  tags = {
    Name = var.vpc_network_name
    Env  = var.env
  }
}