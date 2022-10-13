data "aws_availability_zones" "available" {
  state = "available"
}

output "availability_zones" {
    value= data.aws_availability_zones.available.names
}

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


/* output "sg" {
    value= "${module.vpc.sg}"
} */

/* output "public-ip_of_instance" {
    value = module.my-ec2.public-ip_of_instance
} */

/*  output "iam-role" {
    value = module.ecs.iam-role-ARN
} 
 */
 output "vpc_id" {
    value = module.vpc.vpc_id
} 

output "public_subnets" {
    value= module.vpc.public_subnets
}

output "private_subnets" {
    value= module.vpc.private_subnets
}