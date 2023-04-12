resource "aws_launch_configuration" "as_confg" {
    image_id                    = var.image_id
    instance_type               = "t2.micro"
}


// CREATING AUTO SCALING GROUP
resource "aws_autoscaling_group" "as_grp" {
    name                        = "Mukesh-asg"
    # availability_zones          = []                                  # availabilty_zones identifier conflicts with the vpc_zone_identifier
    desired_capacity            = 2
    max_size                    = 8
    min_size                    = 2
    launch_configuration        = aws_launch_configuration.as_confg.name
    
    vpc_zone_identifier         = (var.subnet_id)
}

// AUTO SCALING POLICY 
resource "aws_autoscaling_policy" "as_policy" {
    autoscaling_group_name      = aws_autoscaling_group.as_grp.name
    name                        = "scaling-policy"
    # resource_id                 = aws_autoscaling_group.as_grp.id
    policy_type                 = "TargetTrackingScaling"                   # increase or decrease the current capacity target based on a set of scaling adjustments
    
}

resource "aws_cloudwatch_metric_alarm" "cwma" {
    alarm_name                  = "cpu-utilization-for-asg"
    comparison_operator         = "GreaterThanOrEqualToThreshold"
    evaluation_periods          = "2"                                    # It is the number of period over which data is compared to the specified threshold
    metric_name                 = "CPUUtilization"
    namespace                   = "AWS/EC2"
    period                      = "300"
    statistic                   = "Average"
    threshold                   = "70"
    alarm_description           = "Alarm when CPU exceeds 70%"
    dimensions                  = {
                        instance_id = var.server_id
  }
}



resource "aws_autoscaling_attachment" "as-attach" {
    autoscaling_group_name              = aws_autoscaling_group.as_grp.name
    alb_target_group_arn                 = var.target_group_arn
    # policy_arn                          = aws_autoscaling_policy.as_policy.arn
    

}
