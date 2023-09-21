resource "aws_instance" "bastion_host" {
  depends_on             = [var.ig]
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.bastion_instance_type
  subnet_id              = var.public_subnet_id[0].id
  vpc_security_group_ids = [var.sg]
  availability_zone      = var.availability_zones
  key_name               = aws_key_pair.rsa_key.key_name
  tags = {
    Name = "bastion_host"
  }
} 