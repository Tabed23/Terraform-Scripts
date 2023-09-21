#Configure THE PROVIDER FOR TERRAFORM
terraform {
  #version for terraform
  required_version = ">= 0.13"
  required_providers {
    #rke configuration
    rancher2 = {
      source  = "rancher/rancher2"
      version = "1.24.2"
    }
    #aws configration
    aws = {
      source  = "hashicorp/aws"
      version = "4.38.0"
    }
  }
}
