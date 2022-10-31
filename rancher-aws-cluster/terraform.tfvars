# Default vpc name
vpc_network_name = "aws_network"
# Default cider block
cidr = "10.0.0.0/16"

# Default internet gateway name
ig_gateway_name = "ig_gateway"

# Default nat gateway name
nat_gateway_name = "nat_gateway"

# Default EC2 Type
ec2_type = "t2.large"

# Default public IP address
public_subnets_cidr = ["10.0.16.0/20", "10.0.48.0/20", "10.0.80.0/20"]

# Default private IP address
private_subnets_cidr = ["10.0.0.0/20", "10.0.32.0/20", "10.0.64.0/20"]

# Default environment tyoe
env_type = "development"

# Get the local rsa_public_key
rsa_public_key = "$USER .ssh/id_rsa.pub"