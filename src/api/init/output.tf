output "resource_id" {
  value = aws_api_gateway_resource.kbaas.id
}

output "gateway_role_arn" {
  value = aws_iam_role.gateway.arn
}
