# resource "rke_cluster" "devcluster" {
#   kubernetes_version = var.k8version
#   cloud_provider {
#     name = "aws"
#   }

#   network {
#     plugin = "flannel"
#     options = {
#       flannel_backend_type = "vxlan"
#       } 
#     }
#   delay_on_creation = 60
#   bastion_host {
#     address           = var.bastion_address
#     user              =  var.ssh_username
#     ssh_key           = var.private_key
#   }
#   nodes {
#     address           = var.master_ip
#     user              = var.ssh_username
#     ssh_key           = var.private_key
#     role              = ["controlplane", "etcd", "worker"]
#     hostname_override = "master"
#   }
#   nodes {
#     address           = var.woker_node_ip[0]
#     user              = var.ssh_username
#     ssh_key           = var.private_key
#     role              = ["worker"]
#     hostname_override = "worker"
#   }
#   nodes {
#     address           = var.woker_node_ip[1]
#     user              = var.ssh_username
#     ssh_key           = var.private_key
#     role              = ["worker"]
#     hostname_override = "worker"
#   }

#   upgrade_strategy {
#       drain = true
#       max_unavailable_worker = "20%"
#   }
# }