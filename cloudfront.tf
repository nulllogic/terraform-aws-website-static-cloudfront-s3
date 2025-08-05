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

  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = var.cloudfront.root.default_object
  aliases             = var.route53.domain != null ? [var.route53.domain] : []
  http_version        = "http2and3" # to support both HTTP/2 and HTTP/3"

  origin {
    domain_name              = aws_s3_bucket.main.bucket_regional_domain_name
    origin_id                = aws_s3_bucket.main.bucket
    origin_access_control_id = aws_cloudfront_origin_access_control.oac.id

    origin_shield {
      enabled              = true
      origin_shield_region = "eu-west-1"
    }
  }

  price_class = var.cloudfront.root.price_class

  ordered_cache_behavior {
    target_origin_id = aws_s3_bucket.main.id
    path_pattern     = "/_astro/*"

    allowed_methods = ["GET", "HEAD"]
    cached_methods  = ["GET", "HEAD"]

    cache_policy_id        = aws_cloudfront_cache_policy.astro_cache_policy.id
    viewer_protocol_policy = "redirect-to-https"
    compress               = true
  }

  default_cache_behavior {
    target_origin_id = aws_s3_bucket.main.id
    cache_policy_id  = aws_cloudfront_cache_policy.default_caching.id

    // Add additional security policy rules
    response_headers_policy_id = aws_cloudfront_response_headers_policy.security.id

    allowed_methods = ["GET", "HEAD"]
    cached_methods  = ["GET", "HEAD"]

    compress = true

    function_association {
      event_type   = "viewer-request"
      function_arn = aws_cloudfront_function.request_handler.arn
    }

    viewer_protocol_policy = "redirect-to-https"
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


// CloudFront Astro caching policy
//
resource "aws_cloudfront_cache_policy" "astro_cache_policy" {
  name    = "CloudFront_Astro_caching_policy"
  comment = "Caching policy for files in _astro directory"

  min_ttl     = 3600  // 1 hour
  max_ttl     = 86400 // 24 hours
  default_ttl = 3600

  parameters_in_cache_key_and_forwarded_to_origin {

    cookies_config {
      cookie_behavior = "none"
    }

    headers_config {
      header_behavior = "whitelist"
      headers {
        items = concat(["X-Powered-By", "Cache-Control"])
      }
    }

    query_strings_config {
      query_string_behavior = "none"
    }

    enable_accept_encoding_gzip   = true
    enable_accept_encoding_brotli = true
  }
}

// CloudFront caching policy
//
resource "aws_cloudfront_cache_policy" "default_caching" {
  name = "CloudFront_default_caching_policy"

  min_ttl     = 3600  // 1 hour
  max_ttl     = 86400 // 24 hours
  default_ttl = 3600

  parameters_in_cache_key_and_forwarded_to_origin {

    cookies_config {
      cookie_behavior = "none"
    }

    headers_config {
      header_behavior = "whitelist"
      headers {
        items = concat(["X-Powered-By", "Cache-Control"])
      }
    }

    query_strings_config {
      query_string_behavior = "none"
    }

    enable_accept_encoding_gzip   = true
    enable_accept_encoding_brotli = true
  }
}

// CloudFront function to handle requests
//
resource "aws_cloudfront_function" "request_handler" {
  name    = var.route53.domain != null ? "CloudFront_RHF_${replace(var.route53.domain, ".", "_")}" : "CloudFront_RHF_${random_string.cloudfront_rhf_name.id}"
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

// CloudFront security headers
//

resource "aws_cloudfront_response_headers_policy" "security" {

  name    = var.route53.domain != null ? "CloudFront_SHP_${replace(var.route53.domain, ".", "_")}" : "CloudFront_SHP_${random_string.cloudfront_rhf_name.id}"
  comment = "CloudFront Security Headers Policy configuration"

  custom_headers_config {

    items {
      header   = "permissions-policy"
      override = true
      value    = "geolocation=()"
    }

    items {
      header   = "X-Permitted-Cross-Domain-Policies"
      override = true
      value    = "none"
    }

    items {
      header   = "X-Powered-By"
      value    = "Passion & Agression"
      override = true
    }
  }

  security_headers_config {

    content_type_options {
      override = true
    }

    frame_options {
      frame_option = "DENY"
      override     = true
    }

    referrer_policy {
      referrer_policy = "same-origin"
      override        = true
    }

    xss_protection {
      mode_block = true
      protection = true
      override   = true
    }

    strict_transport_security {
      access_control_max_age_sec = "63072000"
      include_subdomains         = true
      preload                    = true
      override                   = true
    }

  }

  server_timing_headers_config {
    enabled       = true
    sampling_rate = 50
  }
}

// Random name generator for OAC bucket policy
//
resource "random_string" "oac" {
  length  = 6
  special = false
  numeric = true
}

// Random name generator for OAC bucket policy
//
resource "random_string" "cloudfront_rhf_name" {
  length  = 8
  special = false
  numeric = true
}

