# This will be used by the public subnets
resource "aws_internet_gateway" "ig" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.name}-igw"
    Env  = var.env
  }
}

# elastic ip for the nat gateway
resource "aws_eip" "nat_eip" {
  vpc = true
}

# Nat gateway for the private subnets
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = element(aws_subnet.public.*.id, 0)
  tags = {
    Name = "${var.name}-nat"
    Env  = var.env
  }
}