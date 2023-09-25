# Read common variables
locals {
  s3 = yamldecode(file("settings.yaml"))
}

# Include parent terragrunt.hcl
include {
  path = find_in_parent_folders()
}

# Load module
terraform {
  source = "../../..//modules/s3"
}

# Pass required inputs to module
inputs = local.s3
