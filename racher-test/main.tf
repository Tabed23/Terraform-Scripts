terraform {
 required_providers {
   rancher2 = {
     source = "rancher/rancher2"
     version = "1.24.2"
   }
 }
}
provider "rancher2" {
 api_url    = "https://rancher.gpay.tech"
 access_key = "token-kkp5t"
 secret_key = "xdfcmzgws7p67hdr86vq2b9gr8tdl59vnr57hnxvm7dv52hlkvlthl"
}
# Create a new rancher2 Node Template from Rancher 2.2.x
resource "rancher2_cloud_credential" "foo" {
  name = "foo"
  description = "foo test"
  amazonec2_credential_config {
    access_key = "AKIA5XKRA3XYNH33SHJZ"
    secret_key = "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"
  }
}

data "rancher2_node_template" "foo" {
  name = "node-template-manual"
}
output "name" {
  value = data.rancher2_node_template.foo.
}
resource "rancher2_node_template" "foo" {
  name = "foo"
  description = "foo test"
  cloud_credential_id = rancher2_cloud_credential.foo.id
  amazonec2_config {
    ami =  "ami-0f540e9f488cfa27d"
    iam_instance_profile = "master_profile"
    userdata = file("./docker.sh")
    region = "eu-west-2"
    security_group = ["eu-west-2-aws_network-bastion-sg"]
    subnet_id = "subnet-0a5cff92348dec4a2"
    vpc_id = "vpc-036e7e851fa92a6e7"
    zone = "a"
  }
}

resource "rancher2_cluster" "cluster" {
 name = "kubernetes"
 description = "Name of the Kubernetes cluster"
 rke_config {
   cloud_provider{
     name = "aws"
   }
   kubernetes_version = "v1.20.11-rancher1-1"
   network {
     plugin = "flannel"
     options = {
         flannel_backend_type = "vxlan"
     }
   }
 }
}
# Create a new rancher2 Node Pool for control plane node
resource "rancher2_node_pool" "masters" {
 cluster_id =  rancher2_cluster.cluster.id
 name = "master"
 hostname_prefix =  "master"
 node_template_id = rancher2_node_template.foo.id
 quantity = 1
 control_plane = true
 etcd = true
 worker = false
}
resource "rancher2_node_pool" "worker" {
 cluster_id =  rancher2_cluster.cluster.id
 name = "worker"
 hostname_prefix =  "worker"
 node_template_id = rancher2_node_template.foo.id
 quantity = 1
 control_plane = false
 etcd = false
 worker = true
}