resource "aws_instance" "bastion_host" {
  
  ami= data.aws_ami.ubuntu.id

  instance_type = var.instance_type

  subnet_id = var.public_subnet_id

  vpc_security_group_ids= [var.ec2sg]  
  
  availability_zone = var.availability_zones

  key_name = aws_key_pair.rsa_key.key_name
  user_data = "${file("bastion_host.sh")}"
  tags = {
      Name= "bastion_host"
     /*  tag = "${var.pem}" */
    }
} 