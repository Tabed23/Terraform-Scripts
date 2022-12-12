resource "aws_ami_from_instance" "nginx" {
  name               = "nginx-ami"
  source_instance_id = "${aws_instance.nginx-ec2.id}"
}