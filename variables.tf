variable "inst_count" {
  description = "The nunber of instances to be deployed"
  default     = 1
}

variable "region" {}

variable "machine-ami" {}

variable "remote_organization" {
  description = "org where Remote Workspace for Subnet/Security Group is defined"
}

variable "subnet_remote_workspace_name" {
  description = "Remote Workspace where subnet is defined"
}

variable "token_org" {
  description = "Token for the Org"
}