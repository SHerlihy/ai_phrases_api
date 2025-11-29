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

data "archive_file" "authorizer" {
  type        = "zip"
  source_file = "${path.module}/deployment.py"
  output_path = "${path.module}/deployment.zip"
  output_file_mode = "0666"
}

resource "aws_lambda_function" "authorizer" {
  filename = data.archive_file.authorizer.output_path
  handler = "deployment.lambda_handler"
  function_name = "authorizer"
  runtime = "python3.14"
  architectures = ["x86_64"]
  
  timeout = 60
  role = var.lambda_exec_role
  environment {
    variables = {
      AUTH_KEY = var.auth_key
    }
  }
}
