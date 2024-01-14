#------------------------------------------------------------------------------
# S3 bucket configuration
#------------------------------------------------------------------------------

// S3 bucket init
//
resource "aws_s3_bucket" "main" {
  provider = aws.main
  bucket   = var.s3.bucket != null ? var.s3.bucket : "s3-bucket-${random_uuid.uuid.result}"

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

// Random name generator for s3 bucket
//
resource "random_uuid" "uuid" {}

// Upload dummy index.html file to s3 bucket
//

resource "aws_s3_object" "index" {
  count        = var.enable.s3.index_html != false ? 1 : 0
  bucket = aws_s3_bucket.main.bucket
  key    = "index.html"

  content_type = "text/html"
  content      = <<EOF
    <!DOCTYPE html>
    <html lang="en">
      <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>My Website</title>
      </head>
      <body>
        <main>
            <h1>Welcome to My Website</h1>
        </main>
      </body>
    </html>
  EOF 
}

// Upload files to s3 bucket
//
resource "aws_s3_object" "upload_dir" {
  count        = var.enable.s3.upload_dir != "" ? 1 : 0
  bucket       = aws_s3_bucket.main.bucket
  key          = "/cloud"
  content_type = "application/x-directory"
}
