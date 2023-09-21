resource "aws_s3_bucket" "s3_bucket" {
  count  = 2
  bucket = "${var.bucket_name}-${var.env_type}-${count.index}"

  tags = {
    Environment = var.env_type
  }
}
resource "aws_s3_bucket_acl" "my_protected_bucket_acl" {
  count  = length(aws_s3_bucket.s3_bucket)
  bucket = element(aws_s3_bucket.s3_bucket.*.id, count.index)
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "my_protected_bucket_versioning" {
  count  = length(aws_s3_bucket.s3_bucket)
  bucket = element(aws_s3_bucket.s3_bucket.*.id, count.index)
  versioning_configuration {
    status = "Enabled"
  }
}