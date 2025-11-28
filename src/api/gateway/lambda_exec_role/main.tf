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

resource "aws_iam_role" "lambda_exec" {
  name = "serverless_lambda"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Sid    = ""
      Principal = {
        Service = "lambda.amazonaws.com"
      }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_exec" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_policy_document" "api_gateway_exec" {
    statement {
        effect = "Allow"

        actions = [
            "lambda: InvokeFunction"
        ]

        principals {
            type = "AWS"
            identifiers = [var.api_arn]
        }
        
        resources = var.lambda_arns
    }
}

resource "aws_iam_role_policy_attachment" "api_gateway_exec" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = aws_iam_policy_document.api_gateway_exec.arn
}
