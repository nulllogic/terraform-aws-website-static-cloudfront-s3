```hcl
module "website-static-cloudfront-s3" {
  source  = "nulllogic/website-static-cloudfront-s3/aws"

  providers = {
    aws.main         = aws.main
    aws.acm_provider = aws.acm_provider
  }

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}
```
