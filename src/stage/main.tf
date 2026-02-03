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

variable "stage_uid" {
  type = string
}

variable "api_id" {
  type = string
}

resource "aws_api_gateway_deployment" "kbaas" {
  rest_api_id = var.api_id 

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "kbaas" {
  rest_api_id = var.api_id
  deployment_id = aws_api_gateway_deployment.kbaas.id
  stage_name    = var.stage_uid
}

resource "aws_api_gateway_usage_plan" "kbaas" {
  name         = "kbaas${var.stage_uid}"

  api_stages {
    api_id = var.api_id
    stage  = aws_api_gateway_stage.kbaas.stage_name
  }

  quota_settings {
    limit  = 99
    offset = 0
    period = "DAY"
  }

  throttle_settings {
    rate_limit  = 10
    burst_limit = 5
  }
}

output "api_path" {
    value = aws_api_gateway_stage.kbaas.invoke_url
}
