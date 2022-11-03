
data "aws_acm_certificate" "issued" {
  domain   = "*.${var.domain_name}"
  statuses = ["ISSUED"]
}
resource "aws_lb_target_group" "target-group" {
    depends_on=[aws_instance.worker_nodes, data.aws_acm_certificate.issued]
     vpc_id = var.vpc_id
    name = var.target_group_name
    port = 80
    protocol = "HTTP"
    target_type = "instance" # ip
   
   health_check {
        interval = 10
        path = "/healthz"
        protocol = "HTTP"
        timeout = 8
        healthy_threshold = 2
        unhealthy_threshold = 7
    }
}

resource "aws_alb_target_group_attachment" "attach_to_ec2" {
    depends_on=[aws_instance.worker_nodes, data.aws_acm_certificate.issued]
    count= length(aws_instance.worker_nodes)
    target_group_arn = aws_lb_target_group.target-group.arn
    target_id = element(aws_instance.worker_nodes.*.id, count.index)
    port             = 80
}

resource "aws_lb" "alb" {
    depends_on=[aws_instance.worker_nodes, data.aws_acm_certificate.issued]
    name = var.load_balancer_name
    internal = false
    security_groups = [var.ec2sg]

    subnets = var.public_subnet_id.*.id

    ip_address_type = "ipv4"
    load_balancer_type = "application"
}

resource "aws_lb_listener" "alb_listener" {
    depends_on=[aws_instance.worker_nodes, data.aws_acm_certificate.issued]
    load_balancer_arn = aws_lb.alb.arn
    port = 80
    protocol = "HTTP"

    default_action  {
        type = "redirect"
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
  depends_on=[aws_instance.worker_nodes, data.aws_acm_certificate.issued]
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