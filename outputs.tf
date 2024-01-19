output "bucket_name" {
  description = "Bucket name corresponding to the S3."
  value       = aws_s3_bucket.main.bucket
}

output "cloudfront_url" {
  description = "Domain name corresponding to the CloudFront distribution."
  value       = aws_cloudfront_distribution.cloudfront.domain_name
}

output "cloudfront_csp_nonce" {
  description = "Nonce value for Content Security Policy"
  value = random_string.cloudfront_csp_nonce.id
}
