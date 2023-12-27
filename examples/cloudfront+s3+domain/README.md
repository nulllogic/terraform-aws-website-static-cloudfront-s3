```hcl
module "website-static-cloudfront-s3" {
  source  = "nulllogic/website-static-cloudfront-s3/aws"

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}
```
