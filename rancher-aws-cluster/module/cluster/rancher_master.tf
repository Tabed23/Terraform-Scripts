resource "aws_instance" "master_nodes" {
  depends_on= [aws_instance.bastion_host]

  ami= data.aws_ami.ubuntu.id

  instance_type = var.worker_instance_type

  subnet_id = var.private_subnet_id[0].id

  vpc_security_group_ids= [var.ec2sg]  

  availability_zone = var.availability_zones
  
  key_name = aws_key_pair.rsa_key.key_name

  user_data = "${file("./rancher.sh")}"
  
  tags = {
    
      Name= "worker-${count.index}"
    }
} 
 
