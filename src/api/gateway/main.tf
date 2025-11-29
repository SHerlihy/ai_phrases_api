terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  profile = "kbaas"
}

module "exec_role" {
    source = "./lambda_exec_role"
}

module "auth_lambda" {
    source = "./auth_lambda"

    lambda_exec_role = module.exec_role.role_arn
}

#module "api" {
#    source = "./api"
#    
#    authorizer_arn = auth_lambda.arn
#    lambda_exec_role = exec_role.role_arn
#}
#
#output "api_base_path" {
#    value = api.base_path
#}
