provider "aws" {
  profile                  = "<user credentials>"
  shared_credentials_files = ["~/.aws/credentials"]
  region                   = var.region
}

resource "aws_s3_bucket" "buckets" {
  for_each = var.s3_buckets
  bucket   = each.value
  tags = {
    Name = "Bucket_${each.key}"
  }
}

resource "aws_s3_bucket_versioning" "enable_disable_versioning" {
  for_each = aws_s3_bucket.buckets
  bucket   = each.value.id
  versioning_configuration {
    status = var.s3_enable_disable_versioning
  }
}
