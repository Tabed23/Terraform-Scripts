resource "tls_private_key" "rsa" {
  depends_on= [var.ig]
  algorithm = "RSA"

  rsa_bits = 4096
}

resource "aws_key_pair" "rsa_key" {
  depends_on= [var.ig]
  key_name = var.keyname

  public_key = tls_private_key.rsa.public_key_openssh
}

resource "local_file" "instance_key" {
  depends_on= [var.ig]
  content         = tls_private_key.rsa.private_key_pem
  file_permission = "776"
  filename        = var.keyname
}
