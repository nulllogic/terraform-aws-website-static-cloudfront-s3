#------------------------------------------------------------------------------
# CloudFront configuration
#------------------------------------------------------------------------------

// Amazon CloudFront OAI (origin access identity)
// -- Not using, due AWS recommends to use OAC
// -- https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/private-content-restricting-access-to-s3.html

// CloudFront OAC (origin access control) 
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
  aliases             = !try(var.route53.domain, null) ? [var.route53.domain] : []

  origin {
    domain_name              = aws_s3_bucket.main.bucket_regional_domain_name
    origin_id                = aws_s3_bucket.main.bucket
    origin_access_control_id = aws_cloudfront_origin_access_control.oac.id
  }

  price_class     = var.cloudfront.root.price_class
  enabled         = true
  is_ipv6_enabled = true

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = aws_s3_bucket.main.bucket
    compress         = true

    min_ttl     = var.cloudfront.cache_behavior.min_ttl
    max_ttl     = var.cloudfront.cache_behavior.max_ttl
    default_ttl = var.cloudfront.cache_behavior.default_ttl

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
    cloudfront_default_certificate = !try(var.route53.domain, null) ? null : true
    acm_certificate_arn            = !try(var.route53.domain, null) ? aws_acm_certificate.cert[0].arn : null
    ssl_support_method             = "sni-only"
    minimum_protocol_version       = var.cloudfront.root.minimum_protocol_version
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  tags = var.tags
}
