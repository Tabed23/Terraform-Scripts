output "id" {
  value = aws_vpc.vpc.id
}

output "public_subnets" {
  value = aws_subnet.public[*].cidr_block
}

output "private_subnets" {
  value = aws_subnet.private[*].cidr_block
}

output "bastion_sg" {
    value= "${aws_security_group.ssh-http-sg.id}"
}