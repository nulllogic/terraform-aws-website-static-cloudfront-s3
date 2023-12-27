### ┌ Basic version ┐
No extra configuration settings is required to run the module

```hcl
module "website-static-cloudfront-s3" {
  source  = "nulllogic/website-static-cloudfront-s3/aws"

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
  bucket = "test-bucket-s3"

  # Region, that you want use at AWS
  region = "eu-west-1"

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
  bucket = "test-bucket-s3"

  # Region, that you want use at AWS
  region = "eu-west-1"

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}
```

PS Try to keep tags, it might be helpful for you in the future ( you can change values there too )
