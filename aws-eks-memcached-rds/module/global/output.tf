output "eks_cluster_role" {
  value = aws_iam_role.eks_cluster
}

output "eks_nodes_role" {
  value = aws_iam_role.nodes
}
output "instance_profile" {
  value = aws_iam_instance_profile.instance_profile.name
}