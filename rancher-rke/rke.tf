# provider "rke" {
#   debug    = true
#   log_file = "rancher.log"
# }

# resource "rke_cluster" "glolab-cluster" {
#   cluster_name = "gloabl-rke"
#   kubernetes_version = var.k8version
#   cloud_provider {
#     name = "aws"
#   }

#   network {
#     plugin = "canal"
#     options = {
#       flannel_backend_type = "vxlan"
#     }
#   }
#   delay_on_creation = 60

#   bastion_host {
#     address = module.global-cluster.bastion_host_ip
#     user    = var.ssh_username
#     ssh_key = var.private_key
#   }

#   nodes {
#     address           = module.global-cluster.master_instance_ip
#     user              = var.ssh_username
#     ssh_key           = var.private_key
#     role              = ["controlplane", "etcd", "worker"]
#     hostname_override = "master"
#   }
#   nodes {
#     address           = module.global-cluster.worker_instance_ip[0]
#     user              = var.ssh_username
#     ssh_key           = var.private_key
#     role              = ["worker"]
#     hostname_override = "worker"
#   }

#   # nodes {
#   #   address           = module.global-cluster.worker_instance_ip[1]
#   #   user              = var.ssh_username
#   #   ssh_key           = var.private_key
#   #   role              = ["worker"]
#   #   hostname_override = "worker"
#   # }

#   upgrade_strategy {
#     drain                  = true
#     max_unavailable_worker = "20%"
#   }
# }