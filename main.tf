terraform {
  backend "remote" {

    required_version = "~> 0.12.6"
    organization = "fanniemae_pov"

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