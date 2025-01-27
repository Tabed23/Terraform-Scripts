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


output "rancher_host_ip" {
  value = aws_instance.rancher.public_ip
}
output "rancher_server" {
  value = aws_instance.rancher
}