#------------------------------------------------------------------------------
# S3 bucket configuration
#------------------------------------------------------------------------------

// S3 bucket init
//
resource "aws_s3_bucket" "main" {
  provider = aws.main
  bucket   = !try(var.s3.bucket, null) ? var.s3.bucket : "my-s3-bucket-${random_uuid.uuid.result}"

  force_destroy = true

  lifecycle {
    prevent_destroy = false
  }

  tags = var.tags
}

// Make S3 bucket private
// -- we don't need to make out bucket public and allow direct access to bucket
//
resource "aws_s3_bucket_public_access_block" "main" {

  bucket = aws_s3_bucket.main.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

}

// Bucket policy
// -- Applying AWS policy document to S3 bucket
// 
resource "aws_s3_bucket_policy" "main" {
  bucket = aws_s3_bucket.main.id
  policy = <<EOF
  {
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "CloudFront_Access",
            "Effect": "Allow",
            "Principal": {
                "Service": "cloudfront.amazonaws.com"
            },
            "Action": [
              "s3:GetObject"
			      ],
            "Resource": "${aws_s3_bucket.main.arn}/*",
            "Condition": {
              "StringEquals": {
                "AWS:SourceArn": "${aws_cloudfront_distribution.cloudfront.arn}"
               }
            }
        }
    ]
  }
  EOF
}

// Bucket ownership
// -- Objects uploaded to the bucket change ownership 
// -- to the bucket owner if the objects are uploaded 
// -- with the bucket-owner-full-control canned ACL
//
resource "aws_s3_bucket_ownership_controls" "main" {
  bucket = aws_s3_bucket.main.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

// Custom name generator for s3 bucket

resource "random_uuid" "uuid" {}
