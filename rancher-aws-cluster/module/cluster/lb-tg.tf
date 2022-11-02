#----------------------TARGET GROUP---------------------
resource "aws_lb_target_group" "my-target-group" {
    depends_on=[aws_instance.worker_nodes]
     vpc_id = var.vpc_id
    name = var.target_group_name
    port = 80
    protocol = "HTTP"
    target_type = "instance" # ip
   
    health_check {
        interval = 10
        path = "/"
        protocol = "HTTP"
        timeout = 5
        healthy_threshold = 3
        unhealthy_threshold = 7
    }
}

resource "aws_alb_target_group_attachment" "test" {
    depends_on=[aws_instance.worker_nodes]
    count= length(aws_instance.worker_nodes)
  target_group_arn = aws_lb_target_group.my-target-group.arn
  target_id = element(aws_instance.worker_nodes.*.id, count.index)
  port             = 80
}

#---------------------LOAD BALANCER------------------------
resource "aws_lb" "my-load-balancer" {
    depends_on=[aws_instance.worker_nodes]
    name = var.load_balancer_name
    internal = false
    security_groups = [var.ec2sg]

    subnets = var.public_subnet_id.*.id

    ip_address_type = "ipv4"
    load_balancer_type = "application"
}

resource "aws_lb_listener" "my_alb_listener" {
    depends_on=[aws_instance.worker_nodes]
    load_balancer_arn = aws_lb.my-load-balancer.arn
    port = 80
    protocol = "HTTP"

    default_action  {
        type = "forward"
        target_group_arn = aws_lb_target_group.my-target-group.arn
    }
} 