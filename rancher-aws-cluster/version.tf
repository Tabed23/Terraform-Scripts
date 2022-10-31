#Configure THE PROVIDER FOR TERRAFORM
terraform {
  #version for terraform
  required_version = ">= 0.13"
  required_providers {
    # rke = {
    #   source  = "rancher/rke"
    #   version = "1.3.4"
    # }
    #aws configration
    aws = {
      source  = "hashicorp/aws"
      version = "4.37.0"
    }
  }
}
