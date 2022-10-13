 resource "aws_ecs_task_definition" "app" {
    family = var.task_definition_name
    network_mode = "awsvpc"
    execution_role_arn= aws_iam_role.ecs_task_execution_role.arn
    requires_compatibilities = ["FARGATE"]
    cpu = var.td_cpu
    memory = var.td_memory
    depends_on= [aws_ecr_repository.demo-repository]
 container_definitions = <<DEFINITION
 [
    {
      "name" : "${var.containername}",
      "image" :"${data.aws_ecr_repository.service.repository_url}",
      "essential" : true,
      "portMappings" :[
        {
          "containerPort" : ${var.container_port},
          "hostPort"      : ${var.host_port}
        }
      ],
      "memory" : ${var.container_memory},
      "cpu" : ${var.container_cpu}
    }
    ]
    
DEFINITION
}



