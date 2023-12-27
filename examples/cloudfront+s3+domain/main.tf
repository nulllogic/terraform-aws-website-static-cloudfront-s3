#------------------------------------------------------------------------------
# CloudFront + S3 + Custom domain name
#------------------------------------------------------------------------------
module "website-static-cloudfront-s3" {
  source = "nulllogic/website-static-cloudfront-s3/aws"
}
