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

data "aws_region" "current" {}

data "aws_iam_policy_document" "gateway_assume" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["apigateway.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "gateway" {
  name = "${var.build_uid}_gateway_api"
  assume_role_policy = data.aws_iam_policy_document.gateway_assume.json
}

resource "aws_iam_role_policy_attachment" "gateway_log" {
  role       = aws_iam_role.gateway.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonAPIGatewayPushToCloudWatchLogs"
}

resource "aws_api_gateway_account" "kbaas" {
  cloudwatch_role_arn = aws_iam_role.gateway.arn
}

resource "aws_iam_role_policy_attachment" "bucket_access" {
  role       = aws_iam_role.gateway.name
  policy_arn = var.bucket_access_policy
}

resource "aws_api_gateway_resource" "kbaas" {
  rest_api_id = var.api_id
  parent_id   = var.root_id
  path_part   = "${var.build_uid}"
}
