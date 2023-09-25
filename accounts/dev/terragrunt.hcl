locals {
  # Import user specific variables
  user = try(
    yamldecode(file(find_in_parent_folders("user.yaml"))),
    run_cmd("echo", "user.yaml file was not found or is invalid.")
  )

  # Merge global.yaml with settings.yml common, the latter overwrites already defined variables
  common = merge(
    yamldecode(file(find_in_parent_folders("global.yaml"))),
    yamldecode(file("settings.yaml"))
  )

}

remote_state {
  backend  = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config   = {
    bucket                 = "basic-terragrunt-${local.common.env}-state"
    dynamodb_table         = "basic-terragrunt-${local.common.env}-state-lock"
    key                    = "${path_relative_to_include()}/terraform.tfstate"
    region                 = local.common.aws_region
    encrypt                = true
    skip_bucket_versioning = false
  }
}

# Automatically configure provider authentication for AWS
generate provider_auth {
  path      = "provider-auth.tf"
  if_exists = "skip"
  contents  = <<-EOF
provider aws {
  region                  = "${local.common.aws_region}"
}
EOF
}

# Configure terraform with extra arguments, like locking and OKTA authentication
terraform {
  extra_arguments retry_lock {
    commands  = get_terraform_commands_that_need_locking()
    arguments = [
      "-lock-timeout=15m"
    ]
  }
}

# Pass all variables from local.common to modules
inputs = local.common
