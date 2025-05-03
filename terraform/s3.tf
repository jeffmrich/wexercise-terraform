resource "aws_s3_bucket" "db_backup_bucket" {
  bucket = "automode-cluster-five-bucket"
  tags = {
    Name = "automode-cluster-five-bucket"
  }
}
