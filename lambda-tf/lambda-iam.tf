resource "aws_iam_role_policy" "lambda_policy" {
  name = "lambda_policy"
  role = aws_iam_role.lambda_role.id

  policy = "${file("lambda_policy.json")}"
}

resource "aws_iam_role" "lambda_role" {
  name = "lamda_role"

  assume_role_policy = "${file("lambda-role-policy.json")}"
}

