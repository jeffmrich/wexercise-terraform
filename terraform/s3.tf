resource "aws_s3_bucket" "db_backup_bucket" {
  bucket = "wexercise-cluster-bucket"
  tags = {
    Name = "wexercise-cluster-bucket"
  }
}

resource "aws_s3_bucket_public_access_block" "allow_public" {
  bucket                  = aws_s3_bucket.db_backup_bucket.id
  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true   # <-- allow public policies
  restrict_public_buckets = true   # <-- allow public access
}
