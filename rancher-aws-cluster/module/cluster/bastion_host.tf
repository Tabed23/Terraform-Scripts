resource "aws_instance" "bastion_host" {
  ami= data.aws_ami.ubuntu.id

  instance_type = var.instance_type

  subnet_id = var.public_subnet_id

  vpc_security_group_ids= [var.ec2sg]  
  
  availability_zone = var.availability_zones

  key_name = aws_key_pair.rsa_key.key_name
  
  iam_instance_profile = "${aws_iam_instance_profile.instance_profile.name}"
  tags = {
      Name= "bastion_host"
    }
  connection {
    type                = "ssh"
    user                = "ubuntu"
    host                = self.public_ip
    private_key         = var.privatekey
  }
  provisioner "remote-exec" {
    inline = [
      "sudo apt update -y",
      "sudo apt upgrade -y",
      "sudo apt install awscli -y",
      "sudo apt install jq -y",
      "aws secretsmanager get-secret-value --region=${var.region} --query SecretString --secret-id ${var.secret_manager_arn} --output json | jq --raw-output > private_key.pem",
      "chmod 400 private_key.pem"
    ]
  }
} 