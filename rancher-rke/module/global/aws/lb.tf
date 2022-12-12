data "aws_acm_certificate" "issued" {
  depends_on = [var.rancher_server]
  domain     = "*.${var.domain_name}"
  statuses   = ["ISSUED"]
}
resource "aws_lb_target_group" "target-group" {
  depends_on  = [var.rancher_server]
  vpc_id      = var.vpc_id
  name        = var.target_group_name
  port        = 80
  protocol    = "HTTP"
  target_type = "instance" # ip

  health_check {
    interval            = 10
    path                = "/healthz"
    protocol            = "HTTP"
    timeout             = 8
    healthy_threshold   = 2
    unhealthy_threshold = 7
  }
}

resource "aws_alb_target_group_attachment" "attach_to_ec2" {
  depends_on       = [var.rancher_server]
  count            = length(var.rancher_server)
  target_group_arn = aws_lb_target_group.target-group.arn
  target_id        = element(var.rancher_server.*.id, count.index)
  port             = 80
}

resource "aws_lb" "alb" {
  depends_on      = [var.rancher_server]
  name            = "${var.load_balancer_name}-alb"
  internal        = false
  security_groups = [var.sg]

  subnets = var.public_subnet_id.*.id

  ip_address_type    = "ipv4"
  load_balancer_type = "application"
}

resource "aws_lb_listener" "alb_listener" {
  depends_on        = [var.rancher_server]
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"
  # default_action {
  #   type             = "forward"
  #   target_group_arn = aws_lb_target_group.target-group.arn
  # }

  default_action {
    type             = "redirect"
    target_group_arn = aws_lb_target_group.target-group.arn
    redirect {
      port        = 443
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}


# Redirect traffic to target group
resource "aws_alb_listener" "https" {
  depends_on        = [var.rancher_server]
  load_balancer_arn = aws_lb.alb.id
  port              = 443
  protocol          = "HTTPS"

  ssl_policy      = "ELBSecurityPolicy-2016-08"
  certificate_arn = data.aws_acm_certificate.issued.arn

  default_action {
    target_group_arn = aws_lb_target_group.target-group.arn
    type             = "forward"
  }
}

// depend upeon the rancher ui

# resource "aws_lb_target_group" "k8masters-tg" {
#   name     = "${var.target_group_name}-master"
#   port     = 6443
#   protocol = "TCP"
#   vpc_id   = var.vpc_id
# }

# resource "aws_lb_target_group" "k8worker-tg" {
#   name     = "${var.target_group_name}-worker"
#   port     = 443
#   protocol = "TCP"
#   vpc_id   = var.vpc_id
# }

# resource "aws_lb_target_group_attachment" "k8https" {
#   count            = length(aws_instance.worker_nodes)
#   target_group_arn = aws_lb_target_group.k8worker-tg.arn
#   target_id        = element(aws_instance.worker_nodes.*.id, count.index)
#   port             = 443
# }

# resource "aws_lb_target_group_attachment" "k8sapi" {
#   target_group_arn = aws_lb_target_group.k8masters-tg.arn
#   target_id        = aws_instance.master_node.id
#   port             = 6443
# }

# resource "aws_lb" "global-nlb" {
#   name               = "${var.load_balancer_name}-nlb"
#   internal           = false
#   load_balancer_type = "network"
#   subnets = var.public_subnet_id.*.id

#   enable_deletion_protection = false

#   tags = {
#     Name = "global-services-lb"
#   }
# }

# resource "aws_lb_listener" "k8sapilistener" {
#   load_balancer_arn = aws_lb.global-nlb.arn
#   port              = "6443"
#   protocol          = "TCP"

#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.k8masters-tg.arn
#   }
# }

# resource "aws_lb_listener" "k8shttpslistener" {
#   load_balancer_arn = aws_lb.global-nlb.arn
#   port              = "443"
#   protocol          = "TCP"

#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.k8worker-tg.arn
#   }
# }
