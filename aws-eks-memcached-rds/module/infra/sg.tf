# Create a default security for the vpc
resource "aws_security_group" "default" {
  name        = "default-sg"
  description = "Default security group to allow inbound/outbound from the VPC"
  vpc_id      = aws_vpc.vpc.id
  depends_on  = [aws_vpc.vpc]

  ingress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Env = var.env
  }
}

resource "aws_security_group" "eks-sg" {
  name        = "eks-sg"
  description = "eks securtiy group for"
  vpc_id      = aws_vpc.vpc.id
  depends_on  = [aws_vpc.vpc]

  ingress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Env = var.env
  }
}

resource "aws_security_group" "rds-sg" {
  name        = "rds-sg"
  description = "rds securtiy group for"
  vpc_id      = aws_vpc.vpc.id
  depends_on  = [var.rds_sg] 

  ingress {
    from_port       = "0"
    to_port         = "0"
    protocol        = "-1"
    security_groups = [var.rds_sg]
  }

  egress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Env = var.env
  }
}