provider "aws" {
  region = "us-west-2"
}

resource "aws_db_instance" "unencrypted" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  identifier           = "unencrypted-db"
  username             = "dbuser"
  password             = "dbpassword123"
  db_subnet_group_name = aws_db_subnet_group.default.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  skip_final_snapshot  = true
  storage_encrypted = false
}

resource "aws_db_subnet_group" "default" {
  name       = "main"
  subnet_ids = [
    module.vpc.public_subnets[0],
    module.vpc.public_subnets[1]
  ]
}

resource "aws_security_group" "rds_sg" {
  name        = "rds_sg"
  description = "RDS security group"
  vpc_id = aws_vpc.demo-vpc.id
}
