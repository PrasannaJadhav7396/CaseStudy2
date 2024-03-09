resource "aws_launch_configuration" "app" {
  count         = var.env_enabled
  name          = "${var.environment_name}-launch-configuration"
  image_id      = var,ami_id
  instance_type = var.instance_type
}
 
resource "aws_autoscaling_group" "app" {
  count                = var.env_enabled
  launch_configuration = aws_launch_configuration[0].app.id
  min_size             = var.min_size
  max_size             = var.max_size
  desired_capacity     = var.desired_capacity
  vpc_zone_identifier  = ["subnet-6712731978"]

  lifecycle {
    create_before_destroy = true
  }
  
  tag {
    key                 = "Name"
    value               = "${var.environment_name}-instance"
    propagate_at_launch = true
  }
}
 
resource "aws_lb" "app" {
  count              = var.env_enabled
  name               = "${var.environment_name}-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["sg-90120934239"] 
  subnets            = ["subnet-453231352"]         
}

resource "aws_acm_certificate" "cert" {
  count             = var.env_enabled  
  domain_name       = "casestudy2.com"
  validation_method = "DNS"

  tags = {
    Environment = "Dev"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lb_listener" "https" {
  count             = var.env_enabled
  load_balancer_arn = aws_lb[0].app.arn
  port              = var.listener_port
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = aws_acm_certificate.cert[0].arn
 
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group[0].app.arn
  }
}
 
resource "aws_lb_target_group" "app" {
  count    = var.env_enabled
  name     = "${var.environment_name}-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "vpc-324235"
}
