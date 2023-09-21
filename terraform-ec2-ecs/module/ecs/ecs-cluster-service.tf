resource "aws_ecs_cluster" "main" {
  name = var.ecs_cluster_name
}

resource "aws_ecs_service" "hello_world" {
  name            = var.ecs_service_name
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.app.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    security_groups = [var.ECS_sg]
    subnets         = var.private_subnets.*.id
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.my-target-group.id
    container_name   = var.containername
    container_port   = 80
  }

  depends_on = [aws_lb_target_group.my-target-group, aws_ecs_cluster.main, aws_ecs_task_definition.app]
}