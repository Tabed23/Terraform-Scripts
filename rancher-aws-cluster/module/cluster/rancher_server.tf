resource "aws_instance" "rancher_server" {
  depends_on= [aws_instance.bastion_host]

  ami= data.aws_ami.ubuntu.id

  instance_type = var.rancher_instance_type

  subnet_id = var.private_subnet_id[0].id

  vpc_security_group_ids= [var.ec2sg]  

  availability_zone = var.availability_zones
    
  iam_instance_profile = "${aws_iam_instance_profile.master_profile.name}"
  key_name = aws_key_pair.rsa_key.key_name

  user_data = "${file("./rancher.sh")}"
  
  tags = {
    
      Name= "rancher_server"
    }
} 
 
