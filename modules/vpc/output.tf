output "my_vpc_id" {
    description = "ID of VPC"
    value       = aws_vpc.main-vpc.id
}

output "public_subnet" {
    description = "ID for public_subnets"
    value       = aws_subnet.public_subnet[*].id
}

output "private_subnet" {
    description = "ID for private_subnets"
    value       = aws_subnet.private_subnet[*].id
}

output "pivrate_cidr_block" {
    description = "CIDR block of the private subnet created"
    value       = var.private_subnet_cidr
}

output "my_sg" {
    description = "SG for all services in the module"
    value       = aws_security_group.all_sg.id
}

