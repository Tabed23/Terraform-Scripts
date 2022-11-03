# resource "rke_cluster" "rke_aws_cluster" {
#   cluster_yaml = file("cluster.yaml")

#   ssh_agent_auth = true
  
#   ignore_docker_version = true
  
#   kubernetes_version = var.k8version
  
#   upgrade_strategy {
#       drain = true
#       max_unavailable_worker = "20%"
#   }

# }

# module "dev_rancher_infra" {
#   cluster_name = "global-develop"
#   source       = "./aws"
# }

# variable "branch_name" {
#   description = "The name of the branch to run the kustomize build against."
#   type        = string
# }

# terraform {
#   required_providers {
#     rke = {
#       source  = "rancher/rke"
#       version = "~> 1.3.0"
#     }
#   }
# }
# provider "rke" {
#   log_file = "dev_rke_debug.log"
#   debug    = true
# }
# resource "local_file" "dev-rke-node-key" {
#   filename = "./dev-rke-node-key.pem"
#   content  = module.dev_rancher_infra.private_key
#   depends_on = [
#     module.dev_rancher_infra
#   ]
# }

resource "rke_cluster" "devcluster" {
  kubernetes_version = var.k8version
  cloud_provider {
    name = "aws"
  }

  network {
    plugin = "flannel"
  }
  delay_on_creation = 60
  bastion_host {
    address           = var.bastion_address
    user              =  var.ssh_username
    ssh_key           = var.private_key
  }
  nodes {
    address           = var.master_ip
    user              = var.ssh_username
    ssh_key           = var.private_key
    role              = ["controlplane", "etcd", "worker"]
    hostname_override = "master"
  }
  nodes {
    address           = var.woker_node_ip[0]
    user              = var.ssh_username
    ssh_key           = var.private_key
    role              = ["worker"]
    hostname_override = "worker"
  }
  nodes {
    address           = var.woker_node_ip[1]
    user              = var.ssh_username
    ssh_key           = var.private_key
    role              = ["worker"]
    hostname_override = "worker"
  }

  upgrade_strategy {
      drain = true
      max_unavailable_worker = "20%"
  }
}

# resource "local_file" "kube_cluster_yaml" {
#   depends_on = [
#     rke_cluster.devcluster
#   ]
#   filename = "./dev-kube_config_cluster.yml"
#   content  = rke_cluster.devcluster.kube_config_yaml
#   provisioner "local-exec" {
#     command = <<EOT
#     sed -i 's/"https\:\/\/.*/https:\/\/${module.dev_rancher_infra.dev_lb_address}:6443\n    tls-server-name: kubernetes/g' dev-kube_config_cluster.yml
#     EOT
#   }
# }

# resource "null_resource" "clonerepo" {
#   depends_on = [
#     rke_cluster.devcluster
#   ]
#   provisioner "local-exec" {
#     command = <<EOT
#     git clone git@bitbucket.org:cybercents/global-devops-kustomize.git 
#     EOT
#   }
# }
# resource "null_resource" "argocd" {
#   depends_on = [
#     null_resource.clonerepo,
#     local_file.kube_cluster_yaml
#   ]
#   provisioner "local-exec" {
#     command = <<EOT
#     kubectl apply --kubeconfig dev-kube_config_cluster.yml -f ./global-devops-kustomize/env/${var.branch_name}/argocd/environment/argocd-namespace.yaml
#     kustomize build --enable-alpha-plugins ./global-devops-kustomize/env/${var.branch_name}/applications/argocd | kubectl apply --kubeconfig dev-kube_config_cluster.yml -n argocd -f -
#     kustomize build --enable-alpha-plugins ./global-devops-kustomize/env/${var.branch_name} | kubectl apply --kubeconfig dev-kube_config_cluster.yml -n argocd -f -
#     kustomize build --enable-alpha-plugins ./global-devops-kustomize/env/${var.branch_name}/applications/aws-cloud-provider | kubectl apply --kubeconfig dev-kube_config_cluster.yml -f -
#     EOT
#   }
# }