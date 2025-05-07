resource "aws_s3_bucket" "test_bucket" {
  bucket = "test-bucket"
  tags = {
    Name = "test-bucket"
  }
}
