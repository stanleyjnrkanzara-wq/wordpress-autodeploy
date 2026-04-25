terraform {
  required_version = ">= 1.6.0"

  backend "s3" {
    bucket = "wordpress-terraform-state-1777157410"
    key    = "wordpress/terraform.tfstate"
    region = "us-east-1"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "= 5.82.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}
