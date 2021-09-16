provider "aws" {
  region     = "us-east-1"
}

resource "aws_s3_bucket" "demos3" {
    bucket = "${var.bucket_name}"
    acl = "${var.acl_value}"
}