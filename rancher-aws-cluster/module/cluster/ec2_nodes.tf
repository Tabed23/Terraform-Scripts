resource "aws_instance" "bastion_host" {
  ami= data.aws_ami.ubuntu.id
  instance_type = var.ec2
  subnet_id = var.subnet_id
  vpc_security_group_ids= [var.ec2sg]  
  availability_zone = var.availability_zones
  key_name = aws_key_pair.ssh_key.key_name
  user_data= file("./bastion_host.sh") 
  tags = {
      Name= "${var.name_of_instance}-web-server"
    }
} 
 
resource "aws_key_pair" "ssh_key" {
  key_name = var.keyname
  public_key= file(var.keyfile)
} 
 