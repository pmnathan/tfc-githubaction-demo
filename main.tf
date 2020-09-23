terraform {
  backend "remote" {
    organization = "prakash_demo"
    workspaces {
      name = "project1-app-west2-dev"
    }
   }
  }

provider "aws" {
  version = "~> 2.0"
  profile    = "default"
  region     = var.region
}

data "terraform_remote_state" "subnet" {
  backend = "atlas"
  config = {
    address = "https://app.terraform.io"
    name = "${var.remote_organization}/${var.subnet_remote_workspace_name}"
    access_token = var.token_org
  }
}

resource "aws_instance" "example" {
  ami           = var.machine-ami
  instance_type = "c4.8xlarge"
  count         = 4
  subnet_id     = data.terraform_remote_state.subnet.outputs.private_subnets[0]
  tags = {
    Name  = "prakash-demo-${count.index}"
    ttl   = 4
    Owner = "Prakash"
  }
}

module "s3_bucket" {
  source  = "app.terraform.io/fanniemae_pov/s3-bucket/aws"
  version = "1.7.0"
  bucket = "prakash-s3-bucket-002-0200"
  acl    = "private"
  tags = {
    Name  = "s3-simple-demo-prakash"
    ttl   = 120
    Owner = "Prakash"
  }
  versioning = {
    enabled = true
  }
}
