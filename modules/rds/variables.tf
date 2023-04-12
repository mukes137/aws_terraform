
variable "vpc_id" {
    description = "VPC id of the VPC that we have created"
    type        = string
    default     = ""
}


variable "security_group_id" {
   description = "this security group is for all services"
   type        = string
   default     = ""
}


variable "subnet_id" {
    description = "subnet id of the VPC that we have created"
    type        = list(string)
    default     = []
}
