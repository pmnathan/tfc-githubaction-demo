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

# An example resource that does nothing.
resource "null_resource" "example" {
  triggers = {
    value = "A example resource that does nothing! 123456789"
  }
}
