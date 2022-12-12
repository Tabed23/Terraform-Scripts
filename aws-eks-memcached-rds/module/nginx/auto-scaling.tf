resource "aws_autoscaling_group" "web" {
  depends_on       = [aws_lb.alb]
  name             = "ec2-asg"
  min_size         = 1
  desired_capacity = 2
  max_size         = 2

  health_check_type    = "EC2"
  target_group_arns    = ["${aws_lb_target_group.target-group.arn}"]
  launch_configuration = aws_launch_configuration.ec2.name
  enabled_metrics = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupTotalInstances"
  ]
  metrics_granularity = "1Minute"
  vpc_zone_identifier = [
    "${var.public_subnet_id[0].id}",
    "${var.public_subnet_id[1].id}"
  ]

  # Required to redeploy without an outage.
  lifecycle {
    create_before_destroy = true
  }
  tag {
    key                 = "Name"
    value               = "auto-scaling-instance"
    propagate_at_launch = true
  }
}
