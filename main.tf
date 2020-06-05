terraform {
  backend "remote" {
    # The name of your Terraform Cloud organization.
    organization = "fanniemae_pov"

    # The name of the Terraform Cloud workspace to store Terraform state files in.
    workspaces {
      name = "project1-app-east1-dev"
    }
  }
}

provider "aws" {
  version = "~> 2.0"
  region  = "us-east-1"
}



module "s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = "prakash-s3-bucket"
  acl    = "private"

  tags = {
    Name = "S3 Simple Demo"
    ttl  = 0
    Owner = "Prakash"
    
  }
  

  versioning = {
    enabled = true
  }
}