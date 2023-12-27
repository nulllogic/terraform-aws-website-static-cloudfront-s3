output "bucket_name" {
  value = aws_s3_bucket.main.bucket
}

output "cloudfront_url" {
  value = aws_cloudfront_distribution.cloudfront.domain_name
}
