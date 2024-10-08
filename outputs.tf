# Output value definitions

output "function_name" {
  description = "Name of the Lambda function."

  value = aws_lambda_function.lambda_hello_world.function_name
}

output "api_gateway_base_url" {
  description = "Base URL for API Gateway stage."

  value = aws_apigatewayv2_stage.lambda.invoke_url
}

output "cloudfront_domain_name" {
  value = aws_cloudfront_distribution.hello_world.domain_name
}

output "function_url" {
  description = "Function URL."
  value       = aws_lambda_function_url.lambda_hello_world_function_url.function_url
}

output "lambda_invoke" {
  description = "Result of Lambda invocation"
  value       = aws_lambda_invocation.lambda_invocation.result
}
