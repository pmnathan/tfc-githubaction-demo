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


data "terraform_remote_state" "subnet" {
  backend = "atlas"

  config = {
    address = "https://app.terraform.io"
    name = "${var.remote_organization}/${var.subnet_remote_workspace_name}"
    access_token = var.token_org
  }
}


#resource "aws_network_interface" "foo" {
#  subnet_id   = terraform_remote_state.subnet.private_subnets[0]
#  tags = {
#    Name = "primary_network_interface"
#    ttl   = 0
#    Owner = "Prakash"
#  }
#}


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


