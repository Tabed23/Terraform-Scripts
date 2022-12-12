resource "aws_instance" "rancher" {
  ami = data.aws_ami.ubuntu.id

  instance_type = var.instance_type

  subnet_id = var.public_subnet_id[0].id

  vpc_security_group_ids = [var.sg]

  availability_zone = var.availability_zones

  key_name = var.key_name

  #iam_instance_profile = "${aws_iam_instance_profile.instance_profile.name}"
  user_data = file("./rancher.sh")
  tags = {
    Name = "rancher-server"
  }
} 