
resource "aws_instance" "nginx-ec2" {
  ami = data.aws_ami.ubuntu.id

  instance_type = var.ec2_instance_size

  subnet_id = var.public_subnet_id[0].id

  vpc_security_group_ids = [var.sg.id]

  availability_zone    = var.availability_zones
  iam_instance_profile = var.instance_profile
  key_name             = var.key_name
  tags = {
    Name = "nginx"
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    host        = self.public_ip
    private_key = var.private_key
  }
  provisioner "file" {
    source      = "nginx.conf"
    destination = "/home/ubuntu/nginx.conf"
  }
  provisioner "file" {
    source      = "default"
    destination = "/home/ubuntu/default"
  }
  provisioner "remote-exec" {
    inline = [
      "sudo apt update -y",
      "sudo apt upgrade -y",
      "sudo apt-get install nginx -y",
      "sudo rm -f /etc/nginx/nginx.conf",
      "sudo mv /home/ubuntu/nginx.conf /etc/nginx/",
      "sudo rm -f /etc/nginx/sites-available/default",
      "sudo mv /home/ubuntu/default /etc/nginx/sites-available/default"
    ]
  }
}


