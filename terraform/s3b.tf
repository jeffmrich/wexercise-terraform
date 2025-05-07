resource "aws_s3_bucket" "wexercise-test-cluster-bucket" {
  bucket = "wexercise-test-cluster-bucket"
  tags = {
    Name = "wexercise-test-cluster-bucket"
  }
}
