terraform {
  backend "s3" {
    bucket         = "my-first-bucket-dev97"
    key            = "terraform.tfstate"
    region         = "us-east-2"
    dynamodb_table = "iti2"
  }
}