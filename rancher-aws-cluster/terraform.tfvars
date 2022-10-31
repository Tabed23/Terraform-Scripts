# Default vpc name
vpc_network_name = "aws_network"
# Default cider block
cidr = "10.0.0.0/16"

# Default internet gateway name
ig_gateway_name = "ig_gateway"

# Default nat gateway name
nat_gateway_name = "nat_gateway"

public_subnets_cidr = ["10.0.16.0/20", "10.0.48.0/20", "10.0.80.0/20"]

private_subnets_cidr = ["10.0.0.0/20", "10.0.32.0/20", "10.0.64.0/20"]

env_type  = "development"

#bastion host instance
instance_type = "t2.large"

#------- BASTIONHOST

keyname = "bastionhost"
# Get the local rsa_public_key
rsa_public_key = "/home/tabeedhassan/.ssh/id_rsa.pub"

worker_instance_type = "t2.large"

no_of_worker_nodes= 2
