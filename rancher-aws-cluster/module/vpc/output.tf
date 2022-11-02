output "id" {
  value = aws_vpc.vpc.id
}

output "public_subnets" {
  value = aws_subnet.public
}

output "private_subnets" {
  value = aws_subnet.private
}

output "bastion_sg" {
    value= "${aws_security_group.ssh-http-sg.id}"
}
