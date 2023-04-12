// CREATING LOAD BALANCER 
resource "aws_lb" "my_lb" {
   name               = "mukesh-lb"
   internal           = false  
   load_balancer_type = "application"
   security_groups    = [var.security_group_id]
   subnets            = toset(var.subnet_id)

}

// lISTENER IN LOAD BALANCER
resource "aws_lb_listener" "my_lb" {
    load_balancer_arn = aws_lb.my_lb.arn   # Amazon Resource Name uniquely identify AWS resources
    port              = "80"
    protocol          = "HTTP"

    default_action {
        type          = "forward"
        target_group_arn = aws_lb_target_group.my_lb.arn
    }
}


// TARGET GROUP FOR THE LOADBALANCER
resource "aws_lb_target_group" "my_lb" {
  name        = "my-lb-target-group"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "instance"

  tags        = {
            Name    = "Mukesh-TG"
  }


  health_check {
    healthy_threshold   = 3
    unhealthy_threshold = 3
    timeout             = 5
    interval            = 10
    path                = "/"
    port                = "traffic-port"
  }
}

resource "aws_lb_target_group_attachment" "my_lb" {
  target_group_arn = aws_lb_target_group.my_lb.arn
  target_id        = var.instance_id
  port             = 80
}
