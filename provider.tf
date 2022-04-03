provider "aws" {
  region = "eu-central-1"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.21"
    }
  }
}

terraform {
  backend "s3" {
    bucket = "fitscrypt-tf-state"
    key    = "terraform-state/terraform.tfstate"
    region = "eu-central-1"
  }
}