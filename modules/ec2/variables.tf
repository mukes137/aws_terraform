variable  "ami_id"     {
   description = "AMI id to deploy ubuntu ec2 instance"
   type = string 
   default = "ami-0557a15b87f6559cf" 
}

variable "instance_type"{
   description = "Instance type for ec2 instance"
   type = string
   default = "t2.micro"
}


variable "tags" {
   description = "A map of tags to add all resources "
   type = map(string)
   default = {}
}

variable "subnet_id" {
    description                 = "public subnet ids"
    type                        = list(string)
    default                     = []
       
}

# variable "private_subnet" {
#     description                 = "private subnet ids"
#     type                        = list(string)
#     default                     = []
# }

variable "vpc_id" {
    description         = "VPC id to be used where required"
    type                = string
    default             = ""
}


variable "name" {
   description = "VPC where we will create our ec2 instance"
   type = string
   default = "Mukesh"
}

variable "security_group_id" {
   description          = "security group id for all services"
   type                 = string
   default              = ""
                 
}
