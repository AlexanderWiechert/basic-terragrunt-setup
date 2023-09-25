variable "project_name" {
  type = string
}

variable "env" {
  type = string
}

variable "tags" {
  type = map(string)
  default = {
    managed_by       = "Terraform"
    terraform_source = "https://github.com/AlexanderWiechert/basic_terragrunt_setup"
    Environment      = "default"
    Landscape        = "ELASTIC2LS"
    ITServiceName    = "COMMON"
    Name             = "development"
  }
}
