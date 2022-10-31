#Configure THE PROVIDER FOR TERRAFORM
terraform {
  #version for terraform
  required_version = ">= 0.13"
  required_providers {
    rke = {
      source = "rancher/rke"
      version = "1.3.4"
    }
  }
}


provider "rke" {
  log_file = "rke_debug.log"
}
