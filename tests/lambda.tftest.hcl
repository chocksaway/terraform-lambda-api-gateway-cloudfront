# run "lambda_invoke" {
#   command = apply
#
# #   module {
# #     source = "./tests/final"
# #   }
#
#   variables {
#     result = aws_lambda_invocation.lambda_invocation.result
#   }
#
#   assert {
#     condition     = aws_lambda_invocation.lambda_invocation.result == 200
#     error_message = "Website responded with HTTP status ${data.http.index.status_code}"
#   }
# }