terraform {
  backend "remote" {

    organization = "fanniemae_pov"

    workspaces {
      name = "project1-app-east1-dev"
    }
  }
}

provider "aws" {
  version = "~> 2.0"
  profile    = "default"
  region     = var.region
}

resource "aws_instance" "example" {
  ami           = var.machine-ami
  instance_type = "t2.micro"
  count = 3

  tags = {
    Name = "fanniemae-demo-${count.index}"
  }
}


module "s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = "prakash-s3-bucket"
  acl    = "private"

  tags = {
    Name  = "S3 Simple Demo"
    ttl   = 0
    Owner = "Prakash"

  }

  versioning = {
    enabled = true
  }
}
