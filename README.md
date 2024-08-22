
#### Terraform AWS Lambda with Layer, api-gateway and cloudfront.

```
terraform plan
terraform apply
terraform destroy
```

I created an output, with details of API gateway, and Cloudfront endpoints:

Outputs:
```
api_gateway_base_url = "https://???????.execute-api.eu-west-1.amazonaws.com/serverless_lambda_stage"
cloudfront_domain_name = "???????.cloudfront.net"
function_name = "LambdaHelloWorld"
```

The Terraform apply, showing the invocation, and output:

```
$ terraform apply
data.archive_file.lambda_hello_world: Read complete after 0s [id=09af68f7ed976c5a14f035dc943f9283a1635106]
aws_iam_role.lambda_exec: Refreshing state... [id=serverless_lambda]
aws_apigatewayv2_api.lambda: Refreshing state... [id=n8bciaqwq7]
aws_cloudwatch_log_group.api_gw: Refreshing state... [id=/aws/api_gw/serverless_lambda_gw]
aws_cloudfront_distribution.hello_world: Refreshing state... [id=E1HUWRD4F8Y21K]
aws_apigatewayv2_stage.lambda: Refreshing state... [id=serverless_lambda_stage]
aws_iam_role_policy_attachment.lambda_policy: Refreshing state... [id=serverless_lambda-20240201200145515300000002]
aws_lambda_function.lambda_hello_world: Refreshing state... [id=LambdaHelloWorld]
aws_lambda_permission.api_gw: Refreshing state... [id=AllowExecutionFromAPIGateway]
aws_cloudwatch_log_group.hello_world: Refreshing state... [id=/aws/lambda/LambdaHelloWorld]
aws_apigatewayv2_integration.hello_world: Refreshing state... [id=nya2ry1]
aws_apigatewayv2_route.hello_world_options: Refreshing state... [id=6swtye3]
aws_apigatewayv2_route.hello_world: Refreshing state... [id=f04e338]
```


To execute the Lambda via Cloudfront:

```
$ curl -v https://????????.cloudfront.net/serverless_lambda_stage/hello
*   Trying ????????????????...
* Connected to ???????????.cloudfront.net (?????????????????) port 443 (#0)
* ALPN, offering h2
* ALPN, offering http/1.1
  [snip]
  {"message":"Hello, World!"}

To execute the Lambda via API Gateway:

$ curl -v https://???????.execute-api.eu-west-1.amazonaws.com/serverless_lambda_stage/hello
*   Trying ????????????????...
* Connected to ?????????????.execute-api.eu-west-1.amazonaws.com (????????????????) port 443 (#0)
* ALPN, offering h2
* ALPN, offering http/1.1
  [snip]
  {"message":"Hello, World!"}

```

The name of the API Gateway “name” is serverless_lambda_stage

The aws_apigatewayv2_route “route_key” is hello

Don’t forget ```terraform destroy``` - so you don’t incur additional AWS cost.

##### terratest, localstack and tflocal updates

```
$ tflocal apply
data.archive_file.lambda_hello_world: Reading...
data.archive_file.lambda_hello_world: Read complete after 0s

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_apigatewayv2_api.lambda will be created
  + resource "aws_apigatewayv2_api" "lambda" {
      + api_endpoint                 = (known after apply)
      + api_key_selection_expression = "$request.header.x-api-key"
      + arn                          = (known after apply)
      + execution_arn                = (known after apply)
      + id                           = (known after apply)
      + name                         = "serverless_lambda_gw"
      + protocol_type                = "HTTP"
      + route_selection_expression   = "$request.method $request.path"
      + tags_all                     = (known after apply)

      + cors_configuration {
          + allow_methods = [
              + "GET",
              + "HEAD",
              + "OPTIONS",
            ]
        }
    }

  # aws_apigatewayv2_integration.hello_world will be created
  + resource "aws_apigatewayv2_integration" "hello_world" {
      + api_id                                    = (known after apply)
      + connection_type                           = "INTERNET"
      + id                                        = (known after apply)
      + integration_method                        = "POST"
      + integration_response_selection_expression = (known after apply)
      + integration_type                          = "AWS_PROXY"
      + integration_uri                           = (known after apply)
      + payload_format_version                    = "1.0"
      + timeout_milliseconds                      = (known after apply)
    }
[snip]


Apply complete! Resources: 14 added, 0 changed, 0 destroyed.

Outputs:

api_gateway_base_url = "https://9fcdea48.execute-api.eu-west-1.amazonaws.com/serverless_lambda_stage"
cloudfront_domain_name = "32bfead6.cloudfront.localhost.localstack.cloud"
function_name = "KodiakLambdaHelloWorld"
function_url = "http://66znf6yvnqr50zilk9i0ohi630ajouc8.lambda-url.eu-west-1.localhost.localstack.cloud:4566/"
lambda_invoke = "{\"statusCode\":200,\"headers\":{\"Content-Type\":\"application/json\"},\"body\":\"{\\\"message\\\":\\\"Hello, World!\\\"}\"}"
```



