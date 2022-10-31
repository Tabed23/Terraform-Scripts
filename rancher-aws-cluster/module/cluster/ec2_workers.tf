resource "aws_instance" "worker_nodes" {
  count=var.no_of_worker_nodes

  ami= data.aws_ami.ubuntu.id

  instance_type = var.worker_instance_type

  subnet_id = var.private_subnet_id

  vpc_security_group_ids= [var.ec2sg]  

  availability_zone = var.availability_zones
  
  key_name = aws_key_pair.rsa_key.key_name

  user_data= file("./worker.sh") 

  tags = {
    
      Name= "worker_nodes-${count.index}"
    }
} 
 

 