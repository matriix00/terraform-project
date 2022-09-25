resource "aws_iam_policy" "policy" {
  name        = "lambda_policy_ses"
  path        = "/"
  description = "lambda ses policy"


  policy = jsonencode({
   
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ses:SendEmail",
                "ses:SendRawEmail"
            ],
            "Resource": "*"
        }
    ]
})
}




resource "aws_iam_policy_attachment" "lambda-attach" {
  name       = "lambda-ses"
  users      = [aws_iam_user.user.name]
  roles      = [aws_iam_role.iam_for_lambda.name]
  groups     = [aws_iam_group.group.name]
  policy_arn = aws_iam_policy.policy.arn
}


resource "aws_iam_group" "group" {
  name = "test-group"
}
resource "aws_iam_user" "user" {
  name = "test-user"
}


resource "aws_iam_role" "iam_for_lambda" {
  name = "lambda-ses"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_lambda_function" "lambda-ses" {
  
  filename      = "lambda-ses.zip"
  function_name = "lambda-ses"
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "lambda-ses.handler"


  source_code_hash = filebase64sha256("lambda-ses.zip")

  runtime = "nodejs12.x"

  environment {
    variables = {
      foo = "bar"
    }
  }
}

resource "aws_lambda_permission" "allow_bucket" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda-ses.arn
  principal     = "s3.amazonaws.com"
  source_arn    = "arn:aws:s3:::my-first-bucket-dev97"
}


resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = "my-first-bucket-dev97"

  lambda_function {
    lambda_function_arn = aws_lambda_function.lambda-ses.arn
    events              = ["s3:ObjectCreated:*"]
  }

  depends_on = [aws_lambda_permission.allow_bucket]
}
