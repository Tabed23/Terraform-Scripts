data "aws_subnet" "subnet1" {
  id = var.private_subnets[0].id
}

data "aws_subnet" "subnet2" {
  id = var.private_subnets[1].id
}

resource "aws_db_subnet_group" "db_subnet" {
  name       = "db-subnet-group"
  subnet_ids = [data.aws_subnet.subnet1.id, data.aws_subnet.subnet2.id]
}

resource "aws_db_instance" "db" {
  instance_class         = var.db_instance_class
  engine                 = "mysql"
  engine_version         = "8.0.28"
  identifier             = "database-${var.env_type}"
  allocated_storage      = 10
  db_name                = "DB_${var.env_type}"
  username               = var.rds_username
  password               = var.rds_password
  publicly_accessible    = false
  db_subnet_group_name   = aws_db_subnet_group.db_subnet.name
  vpc_security_group_ids = ["${var.db-sg.id}"]
  parameter_group_name   = "default.mysql8.0"
  storage_type           = "gp2"
  skip_final_snapshot    = true
}