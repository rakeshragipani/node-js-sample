locals {
  lambda_zip_location = "output/welcome.zip"
}
 
data "archive_file" "welcome" {
  type        = "zip"
  source_file = "index.js"
  output_path = "${local.lambda_zip_location}"
}

resource "aws_lambda_alias" "alias" {
  name             = "${var.name}"
  description      = "${var.description}"
  function_name    = "${var.function_name}"
  function_version = "${var.function_version}"
}
  

