resource "aws_instance" "worker_nodes" {
  ami= data.aws_ami.ubuntu.id
  instance_type = var.worker_instance_type
  subnet_id = var.subnet_id
  vpc_security_group_ids= [var.ec2sg]  
  availability_zone = var.availability_zones
  key_name = aws_key_pair.ssh_key.key_name
  #user_data= file("./bastion_host.sh") 
  tags = {
      Name= "worker_nodes"
    }
} 
 
resource "aws_key_pair" "ssh_key" {
  key_name = var.keyname
  public_key= file(var.keyfile)
} 
 