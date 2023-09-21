data "aws_ami" "ubuntu" {

  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

output "ami_ubuntu" {
  value = data.aws_ami.ubuntu
}

output "public-ip_of_instance" {
  value = aws_instance.bastion_host.public_ip
}

output "tls_rsa_key" {
  value = tls_private_key.rsa.private_key_pem
}
output "privatekey" {
  sensitive = false
  value     = tls_private_key.rsa.private_key_pem
}

output "alb" {
  value = aws_lb.alb.dns_name
}

output "bastion_host_ip" {
  value = aws_instance.bastion_host.public_ip
}


output "rancher_instance_ip" {
  value = aws_instance.rancher_server.private_ip
}

output "domain_record" {
  value = aws_route53_record.record.name
}

output "instance_profile" {
  value = aws_iam_instance_profile.master_profile.name
}