output "this_lambda_alias_name" {
  description = "The name of the Lambda Function Alias"
  value       = element(concat(data.aws_lambda_alias.existing.*.name, aws_lambda_alias.with_refresh.*.name, aws_lambda_alias.no_refresh.*.name, [""]), 0)
}
