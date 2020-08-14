locals {
  lambda_zip_location = "output/welcome.zip"
  alias_name = "terraform alias"
  alias_desc = "create lambda alias"
  alias_function = "new"
  alias_func_ver = "tf"
}
 
data "archive_file" "welcome" {
  type        = "zip"
  source_file = "index.js"
  output_path = "${local.lambda_zip_location}"
}

resource "aws_lambda_alias" "alias" {
  name             = "${local.alias_name}"
  description      = "${local.alias_desc}"
  function_name    = "${local.alias_function}"
  function_version = "${local.alias_func_ver}"
}
  

