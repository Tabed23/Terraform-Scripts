resource "rke_cluster" "rke_aws_cluster" {
  cluster_yaml = file("cluster.yaml")

  ssh_agent_auth = true
  
  ignore_docker_version = true
  
  kubernetes_version = var.k8version
  
  upgrade_strategy {
      drain = true
      max_unavailable_worker = "20%"
  }

}