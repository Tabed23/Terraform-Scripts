
resource "null_resource" "rbac-role" {
  depends_on = [
    helm_release.nginx_ingress
  ]
  provisioner "local-exec" {
    command = "kubectl apply -f https://raw.githubusercontent.com/kubernetes-sigs/aws-alb-ingress-controller/v1.1.4/docs/examples/rbac-role.yaml  --kubeconfig=kubeconfig.yml"
  }
}

resource "null_resource" "cert_manager_manifest" {
  depends_on = [
    null_resource.rbac-role
  ]

  provisioner "local-exec" {
    command = "kubectl apply -f https://github.com/jetstack/cert-manager/releases/download/v1.10.0/cert-manager.crds.yaml --kubeconfig=kubeconfig.yml"
  }
}
resource "null_resource" "cert_manager_namespace" {
  depends_on = [
    null_resource.cert_manager_manifest
  ]
  provisioner "local-exec" {
    command = "kubectl create namespace cert-manager --kubeconfig=kubeconfig.yml "
  }
}

resource "null_resource" "cert_manager_lable" {
  depends_on = [
    null_resource.cert_manager_namespace
  ]
  provisioner "local-exec" {
    command = "kubectl label namespace cert-manager certmanager.k8s.io/disable-validation=true --kubeconfig=kubeconfig.yml"
  }
}
resource "null_resource" "alb_controller" {
  depends_on = [
    null_resource.cert_manager_namespace
  ]
  provisioner "local-exec" {
    command = "kubectl apply -f v2_1_2full.yml --kubeconfig=kubeconfig.yml"
  }
}