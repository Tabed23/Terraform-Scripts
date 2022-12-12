region = "eu-west-1"
# Default vpc name
vpc_network_name = "eu-west-1-aws_network"
# Default cider block
cidr = "10.0.0.0/16"

# Default internet gateway name
ig_gateway_name = "ig_gateway"

# Default nat gateway name
nat_gateway_name = "nat_gateway"

public_subnets_cidr = ["10.0.1.0/24", "10.0.3.0/24"]

private_subnets_cidr = ["10.0.2.0/24", "10.0.4.0/24"]

env_type = "development"

#bastion host instance
bastion_instance_type = "t2.micro"
#------- BASTIONHOST

keyname = "eks-eu-west-1"

k8sversion = "1.24"

worker_instance_type = "t2.large"

no_of_worker_nodes = 3

node_group_name = "eks-us-east-nodes"

zone_id = "Z04444291NB6TM5YG5RTU"