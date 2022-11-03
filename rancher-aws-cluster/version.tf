#Configure THE PROVIDER FOR TERRAFORM
terraform {
  #version for terraform
  required_version = ">= 0.13"
  #rke configuration
  required_providers {
  rancher2 = {
      source = "rancher/rancher2"
      version = "1.24.2"
    }
    rke = {
      source = "rancher/rke"
      version = "1.3.4"
    }
    #aws configration
    aws = {
      source  = "hashicorp/aws"
      version = "4.38.0"
    }
  }
}
