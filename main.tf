terraform {
  required_providers {
    aws = {
      version = "4.67.0"
      source  = "hashicorp/aws"
    }
  }
  backend "s3" {
    bucket = "terraform-state-390458"
    key    = "github/torbenbn/aws-terraform-sample.tfstate"
    region = "ap-southeast-2"
  }
}

resource "aws_s3_bucket" "test-bucket" {
  bucket = "carried-marlin-surfacing"
}

resource "aws_s3_bucket_ownership_controls" "test-bucket" {
  bucket = aws_s3_bucket.test-bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "test-bucket" {
  depends_on = [aws_s3_bucket_ownership_controls.test-bucket]

  bucket = aws_s3_bucket.test-bucket.id
  acl    = "private"
}

data "aws_s3_bucket" "selected" {
  bucket = "deniable-darkish-squad"
}

output "website_arn" {
  value = data.aws_s3_bucket.selected.arn
}
