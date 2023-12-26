#------------------------------------------------------------------------------
# CloudFront + S3 + Custom domain name
#------------------------------------------------------------------------------
module "website-static-cloudfront-s3" {
  source             = "../../"
  use_default_domain = true
  upload_sample_file = true
}
