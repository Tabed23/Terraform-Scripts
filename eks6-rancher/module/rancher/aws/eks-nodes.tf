resource "aws_eks_node_group" "eks_nodes" {
  cluster_name    = aws_eks_cluster.eks.name
  node_group_name = var.node_group_name
  node_role_arn   = var.nodes_role_arn.arn

  version        = var.k8sversion
  subnet_ids     = var.private_subnets[*].id
  capacity_type  = "ON_DEMAND"
  instance_types = [var.instance_type]

  disk_size = 100

  scaling_config {
    desired_size = var.no_of_worker_nodes
    max_size     = var.no_of_worker_nodes + 1
    min_size     = var.no_of_worker_nodes
  }
  update_config {
    max_unavailable = 1
  }

  labels = {
    role = "general"
  }

}


resource "null_resource" "local-kubeconfig" {
  depends_on = [
    aws_eks_node_group.eks_nodes
  ]
  provisioner "local-exec" {
    command = "aws sts get-caller-identity"
  }
}

resource "null_resource" "local-updatekubeconfig" {
  depends_on = [
    null_resource.local-kubeconfig
  ]
  provisioner "local-exec" {
    command = "aws eks update-kubeconfig --region ${var.region} --name ${var.cluster_name} --kubeconfig kubeconfig.yml"
  }
}

resource "null_resource" "local-eksnode" {
  depends_on = [
    null_resource.local-updatekubeconfig
  ]
  provisioner "local-exec" {
    command = "kubectl get node --kubeconfig kubeconfig.yml"
  }
}
