output "tls_rsa_key" {
  value = tls_private_key.rsa.private_key_pem
}
output "privatekey" {
  sensitive = false
  value     = tls_private_key.rsa.private_key_pem
}

output "aws_keypair" {
  value = aws_key_pair.rsa_key
}

output "eks_cluster_role" {
  value = aws_iam_role.eks_cluster
}

output "eks_nodes_role" {
  value = aws_iam_role.nodes
}