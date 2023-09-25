output "s3_bucket" {
  value = aws_s3_bucket.this.bucket
}

output "s3_bucket_domain_name" {
  value = aws_s3_bucket.this.bucket_domain_name
}

output "s3_website" {
  value = aws_s3_bucket.this.website
}

output "s3_website_domain" {
  value = aws_s3_bucket.this.website_domain
}

output "s3_website_endpoint" {
  value = aws_s3_bucket.this.website_endpoint
}

