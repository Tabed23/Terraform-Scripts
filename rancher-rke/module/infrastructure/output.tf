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


output "aws_certificate" {
  value = aws_acm_certificate.cert.arn
}