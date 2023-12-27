```hcl
#------------------------------------------------------------------------------
# CloudFront + S3 + Custom domain name
  source  = "nulllogic/website-static-cloudfront-s3/aws"

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}
```
