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

# resource "rke_cluster" "devcluster" {
#   kubernetes_version = "v1.23.6-rancher1-1"
#   depends_on = [
#     local_file.dev-rke-node-key,
#     module.dev_rancher_infra
#   ]
#   cloud_provider {
#     name = "external"
#   }

#   network {
#     plugin = "flannel"
#   }
#   delay_on_creation = 60
#   bastion_host {
#     address = module.dev_rancher_infra.dev_bastion_address
#     user    = module.dev_rancher_infra.ssh_username
#     ssh_key = module.dev_rancher_infra.private_key
#   }
#   nodes {
#     # address = module.nodes.addresses[0]
#     address = module.dev_rancher_infra.dev_internal_ips[0]
#     # internal_address = module.nodes.internal_ips[0]
#     user              = module.dev_rancher_infra.ssh_username
#     ssh_key           = module.dev_rancher_infra.private_key
#     role              = ["controlplane", "etcd", "worker"]
#     hostname_override = module.dev_rancher_infra.ec2_names[0]
#   }
#   nodes {
#     # address = module.nodes.addresses[1]
#     address = module.dev_rancher_infra.dev_internal_ips[1]
#     # internal_address = module.nodes.internal_ips[1]
#     user              = module.dev_rancher_infra.ssh_username
#     ssh_key           = module.dev_rancher_infra.private_key
#     role              = ["worker"]
#     hostname_override = module.dev_rancher_infra.ec2_names[1]
#   }
#   nodes {
#     # address = module.nodes.addresses[2]
#     address = module.dev_rancher_infra.dev_internal_ips[2]
#     # internal_address = module.nodes.internal_ips[2]
#     user              = module.dev_rancher_infra.ssh_username
#     ssh_key           = module.dev_rancher_infra.private_key
#     role              = ["worker"]
#     hostname_override = module.dev_rancher_infra.ec2_names[2]
#   }
# }

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