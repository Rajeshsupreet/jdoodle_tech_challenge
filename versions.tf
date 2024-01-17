terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.32.1"
    }
  }

  backend "s3" {
    bucket  = "asgterraformremotestate"
    key     = "terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}