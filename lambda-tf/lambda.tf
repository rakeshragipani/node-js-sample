locals {
  lambda_zip_location = "output/masterbranch.zip"
}
 
data "archive_file" "welcome" {
  type        = "zip"
  source_file = "index.js"
  output_path = "${local.lambda_zip_location}"
}

resource "aws_lambda_function" "test_lambda" {
  filename      = "${local.lambda_zip_location}"
  function_name = "Developmentbranch"
  role          = "${aws_iam_role.iam_for_Developmentlambda.arn}"
  handler       = "index.handler"
 
  source_code_hash = "${base64sha256(local.lambda_zip_location)}"

  runtime = "nodejs12.x"
}
  

