resource "aws_instance" "worker_nodes" {
  depends_on= [aws_instance.bastion_host]
  count=var.no_of_worker_nodes

  ami= data.aws_ami.ubuntu.id

  instance_type = var.worker_instance_type

  subnet_id = var.private_subnet_id[0].id

  vpc_security_group_ids= [var.ec2sg]  

  availability_zone = var.availability_zones
  
  iam_instance_profile = "${aws_iam_instance_profile.worker_profile.name}"

  key_name = aws_key_pair.rsa_key.key_name

  user_data = "${file("./rancher.sh")}"
  
  tags = {
    
      Name= "worker-${count.index}"
    }
} 
 

 