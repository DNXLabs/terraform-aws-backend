resource "aws_s3_bucket" "backend" {
  bucket = "${var.bucket_prefix}-terraform-backend"
}

resource "aws_s3_bucket_versioning" "backend" {
  bucket = aws_s3_bucket.backend.id

  versioning_configuration {
    status = "Enabled"
  }
}

data "aws_kms_alias" "s3" {
  count = var.bucket_sse_algorithm == "aws:kms" ? 1 : 0
  name  = var.kms_master_key_alias
}

resource "aws_s3_bucket_server_side_encryption_configuration" "backend" {
  bucket = aws_s3_bucket.backend.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = var.bucket_sse_algorithm
      kms_master_key_id = var.bucket_sse_algorithm == "aws:kms" ? data.aws_kms_alias.s3[0].arn : null
    }
  }
}
resource "aws_s3_bucket_public_access_block" "backend" {
  bucket = aws_s3_bucket.backend.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_dynamodb_table" "lock" {
  name           = "terraform-lock"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
