#Configure THE PROVIDER FOR TERRAFORM
terraform {
  #rke configuration
  required_providers {
   rancher2 = {
     source = "rancher/rancher2"
   }

    #aws configration
    aws = {
      source  = "hashicorp/aws"
      version = "4.37.0"
    }
  }
}
