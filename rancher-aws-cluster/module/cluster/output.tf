data "aws_ami" "ubuntu" {

    most_recent = true

    filter {
        name   = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
    }

    filter {
        name = "virtualization-type"
        values = ["hvm"]
    }

    owners = ["099720109477"]
}

output "ami_ubuntu" {
  value = data.aws_ami.ubuntu
}

output "public-ip_of_instance" {
    value = aws_instance.web_server.public_ip
}