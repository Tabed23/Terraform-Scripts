                                                         # Create a default security for the vpc
resource "aws_security_group" "default" {
  name        = "${var.vpc_network_name}-default-sg"
  description = "Default security group to allow inbound/outbound from the VPC"
  vpc_id      = aws_vpc.vpc.id
  depends_on  = [aws_vpc.vpc]

  ingress {
    from_port = "0"
    to_port   = "0"
    protocol  = "-1"
    self      = true
  }

  egress {
    from_port = "0"
    to_port   = "0"
    protocol  = "-1"
    self      = "true"
  }
  tags = {
    Env = var.env
  }
}

resource "aws_security_group" "ssh-http-sg" {
  name= "${var.vpc_network_name}-bastion-sg"
   vpc_id = aws_vpc.vpc.id

   ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
   }
   ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
   }
   egress {
    from_port = 0
    to_port = 0 
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
   }
   tags = {
      Name= "${var.env}-ssh-http-sg"
    }
} 