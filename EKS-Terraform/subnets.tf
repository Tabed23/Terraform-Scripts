resource "aws_subnet" "public_sn1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "192.168.0.0/24"
  availability_zone       = "eu-central-1a"
  map_public_ip_on_launch = true
  # A map of tags to assign to the resource.
  tags = {
    Name                              = "public-eu-central-1a"
    "kubernetes.io/cluster/FitScrypt" = "shared"
    "kubernetes.io/role/internal-elb" = 1
  }
}



resource "aws_subnet" "private_sn1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "192.168.128.0/24"
  availability_zone = "eu-central-1b"
  # A map of tags to assign to the resource.
  tags = {
    Name                              = "private-eu-central-1b"
    "kubernetes.io/cluster/FitScrypt" = "shared"
    "kubernetes.io/role/internal-elb" = 1
  }
}

resource "aws_subnet" "private_sn2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "192.168.192.0/24"
  availability_zone = "eu-central-1c"

  # A map of tags to assign to the resource.
  tags = {
    Name                              = "private-eu-central-1c"
    "kubernetes.io/cluster/FitScrypt" = "shared"
    "kubernetes.io/role/internal-elb" = 1
  }
}





output "private_subnets_id1" {
  description = "private subnet1"
  value       = aws_subnet.private_sn1.id
}

output "private_subnets_id2" {
  description = "private subnet 2"
  value       = aws_subnet.private_sn2.id
}

output "public_subnets_id1" {
  description = "public subnet  1"
  value       = aws_subnet.public_sn1.id
}