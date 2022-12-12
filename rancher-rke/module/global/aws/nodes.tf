# resource "aws_instance" "bastion_host" {
#   depends_on = [tls_private_key.rsa]
#   ami        = data.aws_ami.ubuntu.id

#   instance_type = var.instance_type

#   subnet_id = var.public_subnet_id[0].id

#   vpc_security_group_ids = [var.sg]

#   availability_zone = var.availability_zones
#    user_data = file("./bastion.sh")
#   key_name = aws_key_pair.rsa_key.key_name

#   tags = {
#     Name = "bastion_host"
#   }


# }


# resource "aws_instance" "worker_nodes" {
#   depends_on = [aws_instance.bastion_host]
#   count      = var.no_of_worker_nodes

#   ami = data.aws_ami.ubuntu.id

#   instance_type = var.instance_type

#   subnet_id = var.private_subnet_id[0].id

#   vpc_security_group_ids = [var.sg]

#   availability_zone = var.availability_zones

#   iam_instance_profile = aws_iam_instance_profile.worker_profile.name

#   key_name = aws_key_pair.rsa_key.key_name
#    user_data = file("./installation.sh")
#   tags = {

#     Name = "worker-${count.index}"
#   }
# }
 
# resource "aws_instance" "master_node" {
#     depends_on = [aws_instance.bastion_host]

#     ami = data.aws_ami.ubuntu.id

#     instance_type = var.instance_type

#     subnet_id = var.private_subnet_id[0].id

#     vpc_security_group_ids = [var.sg]

#     availability_zone = var.availability_zones
#     user_data = file("./installation.sh")
#     key_name             = aws_key_pair.rsa_key.key_name
#     iam_instance_profile = aws_iam_instance_profile.worker_profile.name
#     tags = {

#       Name = "master_control_plan"
#     }
# }
