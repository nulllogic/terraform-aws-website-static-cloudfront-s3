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
  name                              = var.route53.domain != null ? "CloudFront OAC ${var.route53.domain}" : "CloudFront OAC ${random_string.oac.id}"
  description                       = "CloudFront Origin Access Control"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

// Amazon CloudFront configuration
resource "aws_cloudfront_distribution" "cloudfront" {
  provider = aws.main

  default_root_object = var.cloudfront.root.default_object
  aliases             = var.route53.domain != null ? [var.route53.domain] : []

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

    function_association {
      event_type   = "viewer-request"
      function_arn = aws_cloudfront_function.request_handler.arn
    }

    viewer_protocol_policy = "allow-all"
  }

  viewer_certificate {
    cloudfront_default_certificate = var.route53.domain != null ? null : true
    acm_certificate_arn            = var.route53.domain != null ? aws_acm_certificate.cert[0].arn : null
    ssl_support_method             = "sni-only"
    minimum_protocol_version       = "TLSv1.2_2021"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  tags = var.tags
}


// CloudFront function to handle requests
//
resource "aws_cloudfront_function" "request_handler" {
  name = var.route53.domain != null ? "CloudFront Request Handler Function ${var.route53.domain}" : "CloudFront Request Handler Function ${random_string.oac.id}"
  runtime = "cloudfront-js-2.0"
  comment = "AWS CloudFront edge function requests handler"
  publish = true

  code = <<EOF
    function handler(event) {
        var request = event.request;
        var uri = request.uri;
        
        // Check whether the URI is missing a file name.
        if (uri.endsWith('/')) {
            request.uri += 'index.html';
        } 
        // Check whether the URI is missing a file extension.
        else if (!uri.includes('.')) {
            request.uri += '/index.html';
        }

        return request;
    }
  EOF
}

// Random name generator for OAC bucket policy
//
resource "random_string" "oac" {
  length  = 6
  special = false
  numeric = true
}
