resource "null_resource" "rancher_namespace" {
  provisioner "local-exec" {
    command = "kubectl create namespace cattle-system --kubeconfig=kubeconfig.yml"
  }
}
resource "time_sleep" "wait_50_seconds" {
  depends_on = [helm_release.nginx_ingress]

  create_duration = "50s"
}
#install rancher
resource "helm_release" "rancher" {
  depends_on = [
    time_sleep.wait_30_seconds
  ]
  name       = "rancher"
  repository = "https://releases.rancher.com/server-charts/latest"
  chart      = "rancher"

  namespace = "cattle-system"

  set {
    name  = "hostname"
    value = var.hostname
  }
  set {
    name  = "bootstrapPassword"
    value = "admin"
  }
  set {
    name  = "ingress.tls.source"
    value = "secret"
  }
  set {
    name  = "tls"
    value = "external"
  }
}
resource "null_resource" "roullout-rancher" {
  depends_on = [
    helm_release.rancher
  ]
  provisioner "local-exec" {
    command = "kubectl -n cattle-system rollout status deploy/rancher --kubeconfig=kubeconfig.yml"
  }
}


resource "null_resource" "get-scm" {
  depends_on = [
    null_resource.roullout-rancher
  ]
  provisioner "local-exec" {
    command = "git clone https://github.com/wasi2320/k8s.git"
  }
}

resource "null_resource" "nginx-deploy" {
  depends_on = [
    null_resource.get-scm
  ]
  provisioner "local-exec" {
    command = "kubectl apply -f k8s/ --kubeconfig=kubeconfig.yml"
  }
}