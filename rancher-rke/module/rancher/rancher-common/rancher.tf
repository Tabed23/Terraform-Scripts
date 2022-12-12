# # Rancher resources

# # Initialize Rancher server
# resource "rancher2_bootstrap" "admin" {
#   depends_on = [
#     helm_release.dev_rancher_server
#   ]

#   provider = rancher2.bootstrap

#   password  = var.admin_password
#   telemetry = true
# }
