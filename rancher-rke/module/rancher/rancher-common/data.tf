# Data for rancher common module

# Kubernetes data
# ----------------------------------------------------------

# # Rancher certificates
# data "kubernetes_secret" "rancher_cert" {
#   depends_on = [helm_release.dev_rancher_server]

#   metadata {
#     name      = "tls-rancher-ingress"
#     namespace = "cattle-system"
#   }
# }
