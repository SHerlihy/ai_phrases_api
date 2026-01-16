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

module "init" {
  source = "./init"

  build_uid = var.build_uid

  api_id = var.root.api_id
  root_id = var.root.root_id

  bucket_access_policy = var.bucket.bucket_access_policy
}

module "paths" {
  source = "./path"

  build_uid = var.build_uid

  api_bind = {
    api_id = var.root.api_id
    resource_id = module.init.resource_id
  }

  bucket = {
    bucket_name = var.bucket.bucket_name
    bucket_access_role = module.init.gateway_role_arn
  }

  execution_arn = var.root.execution_arn

  auth_key = var.auth_key

  kb_id = var.kb_id

  source_id = var.source_id
}
