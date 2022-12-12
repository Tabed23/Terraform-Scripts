# elastic ip for the nat gateway
resource "aws_eip" "nat_eip" {
  vpc = true
}

# Nat gateway for the private subnets
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = element(aws_subnet.public.*.id, 0)
  tags = {
    Name = var.nat_gateway_name
    Env  = var.env
  }
}