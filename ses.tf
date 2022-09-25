resource "aws_ses_email_identity" "ses_identify" {

    email = "omar.ud07.2016@gmail.com"
  
}
resource "aws_ses_domain_identity" "ses_domain" {
  domain = "gmail.com"
}

resource "aws_ses_email_identity" "ses_identify2" {

    email = "omar2018.dev@gmail.com"
  
}