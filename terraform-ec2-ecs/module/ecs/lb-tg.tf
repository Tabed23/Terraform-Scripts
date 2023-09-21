#----------------------TARGET GROUP---------------------
resource "aws_lb_target_group" "my-target-group" {
  vpc_id      = var.vpc_id
  name        = var.target_group_name
  port        = 80
  protocol    = "HTTP"
  target_type = "ip" # ip or lamba

  health_check {
    interval            = 10
    path                = "/"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }
}

#---------------------LOAD BALANCER------------------------
resource "aws_lb" "my-load-balancer" {
  name            = var.load_balancer_name
  internal        = false
  security_groups = [var.loadbalancer_sg]

  subnets = var.public_subnets.*.id

  ip_address_type    = "ipv4"
  load_balancer_type = "application"
}

resource "aws_lb_listener" "my_alb_listener" {
  load_balancer_arn = aws_lb.my-load-balancer.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.my-target-group.arn
  }
} 