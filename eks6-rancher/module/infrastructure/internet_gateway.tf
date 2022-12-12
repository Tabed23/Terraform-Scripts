# This will be used by the public subnets
resource "aws_internet_gateway" "ig" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = var.ig_gateway_name
    Env  = var.env
  }
}