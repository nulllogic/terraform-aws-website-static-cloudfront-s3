### ┌ Basic version ┐
No extra configuration settings is required to run the module

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

### ┌ Advanced version ┐
Simple params applied to the module configuration

```hcl
module "website-static-cloudfront-s3" {
  source  = "nulllogic/website-static-cloudfront-s3/aws"

  # Bucket name
  s3.bucket = "test-bucket-s3"

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

### ┌ Complex version ┐
Here you can weak all possible options for S3 + CloudFront configuration

```hcl
module "website-static-cloudfront-s3" {
  source  = "nulllogic/website-static-cloudfront-s3/aws"

  # Bucket name
  s3.bucket = "test-bucket-s3"

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

PS Try to keep tags, it might be helpful for you in the future ( you can change values there too )
