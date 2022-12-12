resource "aws_launch_configuration" "ec2" {
  name_prefix                 = "auto-scaling-for-ec2"
  image_id                    = aws_ami_from_instance.nginx.id
  instance_type               = var.ec2_instance_size
  key_name                    = var.key_name
  security_groups             = [var.sg.id]
  associate_public_ip_address = true
  lifecycle {
    create_before_destroy = true
  }
}

