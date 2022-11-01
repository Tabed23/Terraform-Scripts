
region= "us-east-1"
# Default vpc name
vpc_network_name = "us-east-1-aws_network"
# Default cider block
cidr = "10.0.0.0/16"

# Default internet gateway name
ig_gateway_name = "ig_gateway"

# Default nat gateway name
nat_gateway_name = "nat_gateway"

public_subnets_cidr = ["10.0.1.0/24"]

private_subnets_cidr = ["10.0.2.0/24"]

env_type = "development"

#bastion host instance
instance_type = "t2.large"

#------- BASTIONHOST

keyname = "private_key"

worker_instance_type = "t2.large"

no_of_worker_nodes = 2
