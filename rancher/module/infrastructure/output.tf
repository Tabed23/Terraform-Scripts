output "id" {
  value = aws_vpc.vpc.id
}

output "public_subnets" {
  value = aws_subnet.public
}

output "private_subnets" {
  value = aws_subnet.private
}

output "sg" {
  value = aws_security_group.default.id
}

output "ig" {
  value=aws_internet_gateway.ig
}

output "nat" {
  value= aws_nat_gateway.nat
}