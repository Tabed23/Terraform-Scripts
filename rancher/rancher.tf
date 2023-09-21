provider "rancher2" {
  alias     = "bootstrap"
  api_url   = var.api_url
  bootstrap = true
}
resource "null_resource" "set_initial_state" {
  depends_on = [module.global-cluster.domain_record, module.infrastructure.ig]
  provisioner "local-exec" {
    interpreter = ["bash", "-c"]
    command     = "sleep 120s"
  }
}

data "aws_ami" "ubuntu" {

  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}
# Create a new rancher2_bootstrap using bootstrap provider config
resource "rancher2_bootstrap" "admin" {
  depends_on = [
    null_resource.set_initial_state,
    module.global-cluster.domain_record,
    module.infrastructure.ig
  ]
  provider         = rancher2.bootstrap
  initial_password = "passwordpassword"
  password         = "helloworld1234"
  telemetry        = true
}
provider "rancher2" {

  alias     = "admin"
  api_url   = rancher2_bootstrap.admin.url
  token_key = rancher2_bootstrap.admin.token
  insecure  = true
}
# Create a new rancher2 Node Template from Rancher 2.2.x
resource "rancher2_cloud_credential" "aws_credential" {
  depends_on = [
    null_resource.set_initial_state,
    module.infrastructure.ig,
    module.infrastructure.nat
  ]
  provider    = rancher2.admin
  name        = "aws_rancher"
  description = "rke aws"
  amazonec2_credential_config {
    access_key = var.access_key
    secret_key = var.secret_key
  }
}

resource "rancher2_node_template" "node_template" {
  depends_on = [
    null_resource.set_initial_state,
    module.infrastructure.ig,
    module.infrastructure.nat
  ]
  provider            = rancher2.admin
  name                = "rks-node-template"
  description         = "node template for rke rancher cluster"
  cloud_credential_id = rancher2_cloud_credential.aws_credential.id
  amazonec2_config {
    ami                = data.aws_ami.ubuntu.id
    instance_type      = var.worker_instance_type
    http_endpoint      = "enabled"
    http_tokens        = "optional"
    insecure_transport = false
    region             = var.region
    security_group     = ["rancher-default-sg"]
    subnet_id          = module.infrastructure.public_subnets[0].id # pass the private/public  subnets id from main
    vpc_id             = module.infrastructure.id                   # pass this vpc id from main
    zone               = "a"
    /* private_address_only  = true */
    iam_instance_profile = module.global-cluster.instance_profile
  }
  engine_install_url = "https://releases.rancher.com/install-docker/20.10.sh"
  labels = {
    "cattle.io/creator" = "norman"
  }
}
resource "rancher2_cluster" "cluster" {
  depends_on = [
    null_resource.set_initial_state,
    module.infrastructure.ig,
    module.infrastructure.nat,
    module.infrastructure
  ]
  provider    = rancher2.admin
  name        = "rke-cluster"
  description = "Name of the Kubernetes cluster"
  rke_config {
    cloud_provider {
      name = "aws"
    }
    network {
      plugin = "canal"
    }
    kubernetes_version = var.k8version
  }
}
# Create a new rancher2 Node Pool for control plane node
resource "rancher2_node_pool" "masters" {
  depends_on = [
    null_resource.set_initial_state,
    module.infrastructure.ig,
    module.infrastructure.nat,
    rancher2_cluster.cluster,
    module.infrastructure
  ]
  provider         = rancher2.admin
  cluster_id       = rancher2_cluster.cluster.id
  name             = "master"
  hostname_prefix  = "master"
  node_template_id = rancher2_node_template.node_template.id
  quantity         = 1
  control_plane    = true
  etcd             = true
  worker           = false
}
resource "rancher2_node_pool" "worker" {
  depends_on = [
    null_resource.set_initial_state,
    module.infrastructure.ig,
    module.infrastructure.nat,
    rancher2_cluster.cluster,
    module.infrastructure
  ]
  provider         = rancher2.admin
  cluster_id       = rancher2_cluster.cluster.id
  name             = "worker"
  hostname_prefix  = "worker"
  node_template_id = rancher2_node_template.node_template.id
  quantity         = 3
  control_plane    = false
  etcd             = false
  worker           = true
}