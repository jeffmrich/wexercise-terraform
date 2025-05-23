resource "aws_s3_bucket" "db_backup_bucket" {
  bucket = "wexercise-cluster-bucket"
  tags = {
    Name = "wexercise-cluster-bucket"
  }
}

resource "aws_s3_bucket_public_access_block" "allow_public" {
  bucket                  = aws_s3_bucket.db_backup_bucket.id
  block_public_acls       = false
  ignore_public_acls      = false
  block_public_policy     = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "read_list_world" {
  bucket = aws_s3_bucket.db_backup_bucket.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadList"
        Effect    = "Allow"
        Principal = "*"
        Action    = [
          "s3:GetObject",
          "s3:ListBucket"
        ]
        Resource = [
          "${aws_s3_bucket.db_backup_bucket.arn}",
          "${aws_s3_bucket.db_backup_bucket.arn}/*"
        ]
      }
    ]
  })
  depends_on = [aws_s3_bucket_public_access_block.allow_public]
}
