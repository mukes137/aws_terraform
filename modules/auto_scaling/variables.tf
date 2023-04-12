variable "subnet_id" {
    description                 = "public subnet ids"
    type                        = list(string)
    default                     = []
       
}

variable "target_group_arn" {
    description                 = "resource name for the target group of the load balancer"
    type                        = string
    default                     = ""
}

variable "image_id" {
    description                 = "this is the ami id used to launch the configuration"
    type                        = string
    default                     = "ami-0557a15b87f6559cf"

}

variable "server_id" {
    description                 = "this is the instance id for the server created"
    type                        = string
    default                     = ""
}

