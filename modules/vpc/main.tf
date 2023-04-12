
// VPC CREATION
resource "aws_vpc" "main-vpc" {
    instance_tenancy = "default"
    cidr_block       = "10.0.0.0/22"
    enable_dns_hostnames = false
      tags = {
     Name = "${var.tag}-VPC"
     
   }
}


// SECURITY GROUP CREATED FOR THE VPC
resource "aws_security_group" "all_sg" {
   name   = "all-SG"
   vpc_id = aws_vpc.main-vpc.id                                # alternative way: vpc_id = module.vpc.name_of_output_block_to_print_vpc_id (for this case my_vpc_id) 

   ingress {
      description = "SSH"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
   }

   ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    ="tcp"
    cidr_blocks  = ["0.0.0.0/0"]
   }

   ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    ="tcp"
    cidr_blocks  = ["0.0.0.0/0"]
   }


   ingress {
    description = "Custom Port"
    from_port   = 8000
    to_port     = 8000
    protocol    ="tcp"
    cidr_blocks  = ["0.0.0.0/0"]
   }

   ingress {
      description = "mysql"
      from_port   = 3306
      to_port     = 3306
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
   }

   egress {
    from_port   = 0
    to_port     = 0
    protocol    ="-1"
    cidr_blocks = ["0.0.0.0/0"]
   }

   tags = {
    Name = "${var.name}-SG-lb"
   }
}


// PUBLIC SUBNET PORTION
resource "aws_subnet" "public_subnet" {
    count                   = "${length(var.subnet_cidr)}"                  # Length determines the length of given list for public subnet_cidr
    vpc_id                  = aws_vpc.main-vpc.id
    cidr_block              = "${var.subnet_cidr[count.index]}"             # The count is meata-argument that repeats a module for multiple number of times
    availability_zone       = "${var.azs_num[count.index]}"
    map_public_ip_on_launch = true

    tags = {
        Name = "${var.tag}-publicsubnet"
    }
}


resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.main-vpc.id

    tags = {
        Name = "${var.tag}-IGW"
    }
    
}

resource "aws_route_table" "public_route"{
    vpc_id = aws_vpc.main-vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }

    tags = {
        Name = "${var.tag}-publicroute"
    }
}

resource "aws_route_table_association" "public" {
    # subnet_id      = join("," ,aws_subnet.public_subnet[*].id)            # element reterives an element from a list
    count               = length(var.public_subnet)
    subnet_id           = var.public_subnet[count.index]
    route_table_id      = aws_route_table.public_route.id
}


// PRIVATE SUBNET PORTION
resource "aws_subnet" "private_subnet" {
    count                   = "${length(var.private_subnet_cidr)}"
    vpc_id                  = aws_vpc.main-vpc.id
    cidr_block              = "${var.private_subnet_cidr[count.index]}"
    availability_zone       = "${var.azs_num[count.index]}"
    map_public_ip_on_launch = false

    tags = {
        Name = "${var.tag}-privatesubnet"
    }
}

resource "aws_eip" "one" {
    # network_border_group = "us-east-1"
    vpc                    = true

    tags                   = {
                Name       = "${var.tag}-eip"
    }
}

resource "aws_nat_gateway" "nat_gw" {
    subnet_id               = length(aws_subnet.public_subnet[*].id) > 0 ? element(aws_subnet.public_subnet.*.id, 0) : null
    allocation_id           = aws_eip.one.id

    tags                    = {
                      Name  = "${var.tag}-NAT1"
    }

    depends_on = [aws_internet_gateway.igw]
}

resource "aws_route_table" "private_route" {
    vpc_id = aws_vpc.main-vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_nat_gateway.nat_gw.id
    }

    tags = {
        Name = "${var.tag}-Private-route"
    }
}

resource "aws_route_table_association" "private" {
    # subnet_id      = join("," , aws_subnet.private_subnet[*].id)
    count               = length(var.private_subnet)
    subnet_id           = var.private_subnet[count.index]
    route_table_id      = aws_route_table.private_route.id
}
