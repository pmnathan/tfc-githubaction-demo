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
  instance_type = "t2.small"
  count = 1

  tags = {
    Name = "fanniemae-demo-${count.index}"
    ttl   = 0
    Owner = "Prakash"
  }
}


module "s3_bucket" {
  source  = "app.terraform.io/fanniemae_pov/s3-bucket/aws"
  version = "1.7.0"

  bucket = "prakash-s3-bucket-002"
  acl    = "private"

  tags = {
    Name  = "s3-simple-demo-fanniemae"
    ttl   = 0
    Owner = "Prakash"
  }

  versioning = {
    enabled = true
  }
}


module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 1.26.0"

  name               = "fanniemae-app-dev"
  cidr               = "10.10.10.0/24"
  azs                = ["us-west-2a", "us-west-2b", "us-west-2c"]
  private_subnets    = ["10.10.10.0/27", "10.10.10.32/27", "10.10.10.64/27"]
  public_subnets     = ["10.10.10.96/27", "10.10.10.128/27", "10.10.10.160/27"]
  enable_nat_gateway = true
  single_nat_gateway = true
  tags               = {
    Name  = "fanniemae_ecs_cluster"
    ttl   = 0
    Environment = "dev"
    Owner = "me"
  }
}
