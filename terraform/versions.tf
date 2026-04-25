terraform {
  required_version = ">= 1.0"

  # Store terraform state in S3
  # so GitHub Actions can access it
  backend "s3" {
    bucket = "wordpress-terraform-state-1777157410"
    key    = "wordpress/terraform.tfstate"
    region = "us-east-1"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}
