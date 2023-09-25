# Read common variables
locals {
  vpc = yamldecode(file("settings.yaml"))
}

# Include parent terragrunt.hcl
include {
  path = find_in_parent_folders()
}

# Load module
terraform {
  source = "../../..//modules/vpc"
}

# Pass required inputs to module
inputs = local.vpc
