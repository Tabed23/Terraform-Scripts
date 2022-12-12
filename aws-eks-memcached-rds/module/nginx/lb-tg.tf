resource "aws_lb_target_group" "target-group" {
  vpc_id      = var.vpc_id
  name        = var.target_group_name
  port        = 80
  protocol    = "HTTP"
  target_type = "instance" # ip

  health_check {
    interval            = 10
    path                = "/"
    protocol            = "HTTP"
    timeout             = 8
    healthy_threshold   = 2
    unhealthy_threshold = 7
  }
}

# resource "aws_alb_target_group_attachment" "attach_to_ec2" {
#   target_group_arn = aws_lb_target_group.target-group.arn
#   target_id        = aws_instance.nginx-ec2.id
#   port             = 80
# }

#alb
resource "aws_lb" "alb" {
  name            = "${var.load_balancer_name}-alb"
  internal        = false
  security_groups = [var.sg.id]

  subnets = var.public_subnet_id.*.id

  ip_address_type    = "ipv4"
  load_balancer_type = "application"
}

resource "aws_lb_listener" "alb_listener" {

  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.target-group.arn
    type             = "forward"
  }
}


#---nlb
resource "aws_lb" "test" {
  name               = "${var.load_balancer_name}-nlb"
  internal           = false
  load_balancer_type = "network"
  subnets            = var.public_subnet_id.*.id

}