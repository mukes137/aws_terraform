output "target_group_arn" {
    description             = "amazon resource name for the target group"
    value                   = aws_lb_target_group.my_lb.arn
}
