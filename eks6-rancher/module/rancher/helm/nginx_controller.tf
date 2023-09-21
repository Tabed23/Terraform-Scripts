resource "null_resource" "nginx_namespace" {
  provisioner "local-exec" {
    command = "kubectl create namespace ingress-nginx --kubeconfig=kubeconfig.yml"
  }
}
resource "helm_release" "nginx_ingress" {
  depends_on = [
    null_resource.nginx_namespace
  ]
  name       = "nginx"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  namespace  = "ingress-nginx"
  set {
    name  = "controller.service.type"
    value = "LoadBalancer"
  }
  set {
    name  = "controller.annotations.external-dns\\.alpha\\.kubernetes\\.io/hostname"
    value = "rancher-develop.iamedem.name"
  }
  set {
    name  = "controller.ingressClassResource.default"
    value = "true"
  }
  set {
    name  = "controller.name"
    value = "ngix-controller"
  }

}
resource "time_sleep" "wait_30_seconds" {
  depends_on = [helm_release.nginx_ingress]

  create_duration = "30s"
}
data "kubernetes_service" "nginx-ingress" {
  depends_on = [
    time_sleep.wait_30_seconds
  ]
  metadata {
    namespace = "ingress-nginx"
    name      = "nginx-ingress-nginx-controller"
  }
}
# data "aws_lb" "ingress_lb" {
#   depends_on = [
#     data.kubernetes_service.nginx-ingress
#   ]
#   name = data.kubernetes_service.nginx-ingress.status[0].load_balancer[0].ingress[0].hostname

# }


# resource "aws_route53_record" "record" {
#   depends_on = [data.aws_lb.ingress_lb]
#   zone_id    = var.zone_id  # Replace with your zone ID
#   name       = var.hostname # Replace with your subdomain, Note: not valid with "apex" domains, e.g. example.com
#   type       = "A"
#   ttl        = "60"
#   records    = [data.aws_lb.ingress_lb.name]
# }
