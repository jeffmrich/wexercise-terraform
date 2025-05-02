resource "aws_s3_bucket" "db_backup_bucket" {
  bucket = "automode-cluster-four-bucket"
  tags = {
    Name = "automode-cluster-four-bucket"
  }
}
