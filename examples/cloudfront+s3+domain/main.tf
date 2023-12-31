#------------------------------------------------------------------------------
# CloudFront + S3 + Domain
#------------------------------------------------------------------------------
module "website-static-cloudfront-s3" {
  source  = "nulllogic/website-static-cloudfront-s3/aws"

  providers = {
    aws.main = aws.main
    aws.acm_provider = aws.acm_provider
    random = random
  }

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}

