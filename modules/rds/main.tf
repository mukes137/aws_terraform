terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.56.0"
    }
  }
}


# Configure the AWS Provider
provider "aws" {
    region = "us-east-1"
    profile = "default"
   
}


resource "aws_db_subnet_group" "mysql" {
  name        = "mukesh_subnet_group"
  description = "My database subnet group"
  subnet_ids  = toset(var.subnet_id)
  tags = {
    Name = "mukesh_subnet_group"
  }
}



// Creating mysql databse 

resource "aws_db_instance" "rds" {
  allocated_storage    = 10
  identifier          = "mukeshdb"
  engine                  = "mysql"
  engine_version          = "8.0.28"
  instance_class          = "db.t2.micro"
  username                = "Mukesh"
  password                = "12345678"
  publicly_accessible     = false
  skip_final_snapshot     = true                             # If false then db snapshot is taken before deletion
  # cidr_blocks             = [
  #         module.vpc.private_cidr_block
  # ]

  vpc_security_group_ids  = [var.security_group_id]
  db_subnet_group_name    = aws_db_subnet_group.mysql.name   # If this identifier is not specified then db is created in default VPC or in EC2 classic

  tags = {
    Name = "mukesh_mysql"
  }
}
