data "aws_ecr_repository" "service" {
  name = var.ecr_repo_name
  depends_on= [aws_ecr_repository.demo-repository]
}

output "ecr_repo_name" {
    value = data.aws_ecr_repository.service.repository_url
    depends_on= [aws_ecr_repository.demo-repository]
}
