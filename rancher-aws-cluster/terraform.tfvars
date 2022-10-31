#----------VPC
vpc_network_name = "aws_network"
cidr = "10.0.0.0/16"
ig_gateway_name = "ig_gateway"
nat_gateway_name = "nat_gateway"
public_subnets_cidr = ["10.0.16.0/20", "10.0.48.0/20", "10.0.80.0/20"]
private_subnets_cidr = ["10.0.0.0/20", "10.0.32.0/20", "10.0.64.0/20"]
env_type  = "development"



#------- BASTIONHOST

instance_type = "t2.large"
keyname = "bastionhost"
keyfile = "/home/wasif/.ssh/id_rsa.pub"
worker_instance_type = "t3.medium"
no_of_worker_nodes= 2