resource "aws_s3_bucket" "db_backup_bucket" {
  bucket = "wexercise-cluster-bucket"
  tags = {
    Name = "wexercise-cluster-bucket"
  }
}
