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

data "aws_s3_bucket" "selected" {
  bucket = "deniable-darkish-squad"
}

output "website_arn" {
  value = data.aws_s3_bucket.selected.arn
}
