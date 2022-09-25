# resource "aws_iam_policy" "policy2" {
#   name        = "lambda_policy_trigger"
#   path        = "/"
#   description = "lambda trigger policy"

#   # Terraform's "jsonencode" function converts a
#   # Terraform expression result to valid JSON syntax.
#   policy = jsonencode({
   
    
#     "Version": "2012-10-17",
#     "Statement": [
#         {
#             "Effect": "Allow",
#             "Action": [
#                 "logs:CreateLogGroup",
#                 "logs:CreateLogStream",
#                 "logs:PutLogEvents"
#             ],
#             "Resource": "*"
#         }
#     ]


# },
# {
#     "Version": "2012-10-17",
#     "Statement": [
#         {
#             "Effect": "Allow",
#             "Action": [
#                 "s3:*",
#                 "s3-object-lambda:*"
#             ],
#             "Resource": "*"
#         }
#     ]
# }
# )
# }




# resource "aws_iam_policy_attachment" "lambda_attach_trigger" {
#   name       = "lambda_policy_trigger"
#   users      = [aws_iam_user.user2.name]
#   roles      = [aws_iam_role.iam_for_lambda2.name]
#   groups     = [aws_iam_group.group2.name]
#   policy_arn = aws_iam_policy.policy2.arn
# }

# resource "aws_iam_group" "group2" {
#   name = "test2-group"
# }
# resource "aws_iam_user" "user2" {
#   name = "test2-user"
# }


# resource "aws_iam_role" "iam_for_lambda2" {
#   name = "lambda_policy_trigger"

#   assume_role_policy = <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Action": "sts:AssumeRole",
#       "Principal": {
#         "Service": "lambda.amazonaws.com"
#       },
#       "Effect": "Allow",
#       "Sid": ""
#     }
#   ]
# }
# EOF
# }

# resource "aws_lambda_function" "lambda-trigger" {
#   # If the file is not in the current working directory you will need to include a
#   # path.module in the filename.
#   # filename      = "lambda-trigger.zip"
#   function_name = "lambda-trigger"
#   role          = aws_iam_role.iam_for_lambda2.arn
#   # handler       = "lambda-trigger.handler"

#   # The filebase64sha256() function is available in Terraform 0.11.12 and later
#   # For Terraform 0.11.11 and earlier, use the base64sha256() function and the file() function:
#   # source_code_hash = "${base64sha256(file("lambda_function_payload.zip"))}"
#   # source_code_hash = filebase64sha256("lambda-trigger.zip")

#   # runtime = "Python3.7"

#   environment {
#     variables = {
#       foo = "asdsadas"
#     }
#   }
# }

# resource "aws_lambda_permission" "allow_bucket" {
#   statement_id  = "AllowExecutionFromS3Bucket"
#   action        = "lambda:InvokeFunction"
#   function_name = aws_lambda_function.lambda-ses.arn
#   principal     = "s3.amazonaws.com"
#   source_arn    = aws_s3_bucket.s3.arn
# }

# resource "aws_s3_bucket_notification" "bucket_notification" {
#   bucket = aws_s3_bucket.s3.id

#   lambda_function {
#     lambda_function_arn = aws_lambda_function.lambda-trigger.arn
#     events              = ["s3:ObjectCreated:*"]
#     filter_prefix       = "AWSLogs/"
#     filter_suffix       = ".log"
#   }

#   depends_on = [aws_lambda_permission.allow_bucket]
# }