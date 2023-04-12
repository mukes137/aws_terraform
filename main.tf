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

# module "vpc" {
#     source      = "./modules/vpc"


# }

# module "ec2" {
#     source                    = "./modules/ec2"
#     vpc_id                    = module.vpc.my_vpc_id
#     subnet_id                 = module.vpc.public_subnet
#     security_group_id         = module.vpc.my_sg

# }

# module "db" {
#     source                    = "./modules/rds"
#     subnet_id                = module.vpc.private_subnet
#     security_group_id        = module.vpc.my_sg
#     vpc_id                    = module.vpc.my_vpc_id
# }



# module "lb" {
#   source                      = "./modules/load_balancer"
#   vpc_id                      = module.vpc.my_vpc_id
#   subnet_id                   = module.vpc.public_subnet
#   security_group_id           = module.vpc.my_sg
#   instance_id                 = module.ec2.my_server_id
  
# }

# module "as" {
#   source                      = "./modules/auto_scaling"
#   target_group_arn            = module.lb.target_group_arn
#   server_id                   = module.ec2.my_server_id
#   subnet_id                   = module.vpc.public_subnet
# }

module "sss" {
  source                        = "./modules/s3"
}