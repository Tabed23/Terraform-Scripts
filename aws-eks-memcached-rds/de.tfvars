
region = "us-west-2"
# Default vpc name
vpc_network_name = "us-west-2-aws_network"
# Default cider block
cidr = "10.0.0.0/16"

# Default internet gateway name
ig_gateway_name = "ig_gateway"

# Default nat gateway name
nat_gateway_name = "nat_gateway"

public_subnets_cidr = ["10.0.1.0/24", "10.0.3.0/24"]

private_subnets_cidr = ["10.0.2.0/24", "10.0.4.0/24"]

env_type = "dev"

#bastion host instance
instance_type = "t2.large"
#------- BASTIONHOST

keyname = "private_key"

worker_instance_type = "t2.large"


no_of_worker_nodes = 1

domain_name = "your domain name"



db_instance_class = "db.t3.micro"

rds_username = "admin"

rds_password = "random!password"

# cache

redis_node_type       = "cache.t3.micro"
redis_num_cache_nodes = 1

# EKS
k8sversion = "1.22"


variable "private_key" {
  type    = string
  default = "private_key.pem"
}

#--------------------

load_balancer_name = "lb"

target_group_name = "tg"