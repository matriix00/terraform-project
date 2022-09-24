resource "aws_key_pair" "aws-key" {
  key_name   = "aws-key-1"
  public_key = file("/home/dev97/.ssh/id_rsa.pub")
}