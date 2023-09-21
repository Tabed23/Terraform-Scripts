resource "aws_instance" "rancher" {
  depends_on = [var.ig, var.keypair_dependent]
  ami        = data.aws_ami.ubuntu.id

  instance_type = var.instance_type

  subnet_id = var.public_subnet_id[0].id

  vpc_security_group_ids = [var.sg]

  availability_zone = var.availability_zones

  key_name = var.key_name


  user_data = file("./rancher.sh")
  tags = {
    Name = "rancher-server"
  }
} 