resource "aws_s3_bucket" "db_backup_bucket" {
  bucket = "automode-cluster-bucket"
  tags = {
    Name = "automode-cluster-bucket"
  }
}

resource "aws_s3_bucket_policy" "too_open" {
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
}
