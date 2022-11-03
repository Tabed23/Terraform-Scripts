#Configure THE PROVIDER FOR TERRAFORM
terraform {
  #version for terraform
  required_version = ">= 0.12"
  #rke configuration
  required_providers {
    rke = {
      source  = "rancher2/rke"
      version = "~> 1.3.0"
    }
    rancher2 = {
      source = "rancher/rancher2"
      version = "1.24.2"
    }
    #aws configration
    aws = {
      source  = "hashicorp/aws"
      version = "4.37.0"
    }
  }
}
