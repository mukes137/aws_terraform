
// CREATING THE AWS EC2 INSTANCE INSIDE THE Mukesh-vpc
resource "aws_instance" "my_server" {
   ami                        = var.ami_id
   instance_type              = var.instance_type
   subnet_id                  = element(var.subnet_id, 0)
   vpc_security_group_ids     = [var.security_group_id]
   key_name                   = "naseev"
   #aws_iam_instance_profile  = aws_iam_instance_profile.ec2_profile.id
   root_block_device { 
      volume_size = 8
      volume_type = "gp3"
      encrypted = true
   }

   tags = {
     Name = var.name
   }
}
