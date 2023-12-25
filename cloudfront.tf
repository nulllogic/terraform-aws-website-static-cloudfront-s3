#------------------------------------------------------------------------------
# CloudFront configuration
#------------------------------------------------------------------------------

// Amazon CloudFront origin access identity
// -- We will use this to add principal to S3 bucket policy
resource "aws_cloudfront_origin_access_identity" "oai" {
  provider = aws.main
  comment  = "OAI to restrict access to AWS S3 content"
}

// CloudFront access control 
// -- Manages an AWS CloudFront Origin Access Control, 
// -- which is used by CloudFront Distributions with an Amazon S3 bucket as the origin.
resource "aws_cloudfront_origin_access_control" "oac" {
  name                              = "CloudFront OAC"
  description                       = "CloudFront Origin Access Control"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

// Amazon CloudFront configuration
resource "aws_cloudfront_distribution" "cloudfront" {
  provider = aws.main

  default_root_object = "index.html"
  
  origin {

    domain_name = aws_s3_bucket.main.bucket_regional_domain_name
    origin_id   = aws_s3_bucket.main.bucket
    origin_access_control_id = aws_cloudfront_origin_access_control.oac.id

  }

  price_class     = "PriceClass_200"
  enabled         = true
  is_ipv6_enabled = true

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = aws_s3_bucket.main.bucket
    compress         = true

    min_ttl     = 31536000
    max_ttl     = 31536000
    default_ttl = 31536000

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    /*
    lambda_function_association {
      event_type   = "viewer-request"
      lambda_arn   = aws_lambda_function.short_redirect.qualified_arn
      include_body = false
    }
*/
    viewer_protocol_policy = "allow-all"
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
}


