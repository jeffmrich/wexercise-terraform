resource "aws_key_pair" "db_instance_key" {
  key_name	= "db_instance_key"
  public_key	= file("${path.module}/keypair/db-instance.pub")
}

resource "aws_security_group" "db-sg" {
# vpc_id = aws_vpc.demo-vpc.id
  vpc_id = module.vpc.vpc_id
  name   = "db-sg"

  ingress {
    from_port   = 27017
    to_port     = 27017
    protocol    = "tcp"
    cidr_blocks = ["10.0.7.0/24"]
    # Allow DB traffic from private subnet
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    # Allow ssh traffic from internet
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "db-sg"
  }
}

resource "aws_instance" "db-instance" {
  ami           = "ami-0688ba7eeeeefe3cd"    # Ubuntu, 16.04 LTS
  instance_type = "t2.micro"
  key_name	= aws_key_pair.db_instance_key.key_name
  subnet_id     = module.vpc.public_subnets[0]
  vpc_security_group_ids = [
    aws_security_group.db-sg.id
  ]
  tags = {
    Name = "db-instance"
  }
  metadata_options {
    http_tokens = "required"
  }

  user_data = <<-EOF
      #!/bin/bash
      # Set password for ubuntu user
      echo 'ubuntu:Bl0gger!' | chpasswd

      # Enable password authentication in SSH
      sed -i 's/^#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config
      sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config

      # Restart SSH service to apply changes
      systemctl restart sshd

      apt-get update
      sudo apt-get install -y gnupg

      wget -qO - https://www.mongodb.org/static/pgp/server-3.6.asc | sudo apt-key add -
      echo "deb [ arch=amd64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.6 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-3.6.list

      apt-get update
      sudo apt-get install -y mongodb-org --allow-unauthenticated
  EOF
}

resource "aws_eip" "db-instance-eip" {
  instance = aws_instance.db-instance.id
  domain   = "vpc"
}

