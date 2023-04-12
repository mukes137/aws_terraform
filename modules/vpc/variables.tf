variable "tag" {
    description                 = "Similar tags in the code"
    type                        = string
    default                     = "Mukesh"
}

variable "vpc_id" {
    description                 = "VPC id to be used where required"
    type                        = string
    default                     = ""
}


variable "public_subnet" {
    description                 = "public subnet ids"
    type                        = list(string)
    default                     = []
       
}

variable "private_subnet" {
    description                 = "private subnet ids"
    type                        = list(string)
    default                     = []
}

variable "subnet_cidr" {
    description                 = "subnet cidr for public subnets"
    type                        = list(string)
    default                     = ["10.0.1.0/24" , "10.0.2.0/24"]
}

variable "private_subnet_cidr" {
    description                 = "subnet cidr for private subnets"
    type                        = list(string)
    default                     = ["10.0.3.0/24" , "10.0.0.0/24"]
}

variable "azs_num" {
    description                 = "subnet cidr for public subnets"
    type                        = list(string)
    default                     = ["us-east-1a" , "us-east-1b"]
}

variable "sg_grp_id" {
   description          = "security group id for all services"
   type                 = string
   default              = ""
                 
}

variable "name" {
   description = "VPC where we will create our ec2 instance"
   type = string
   default = "Mukesh"
}
