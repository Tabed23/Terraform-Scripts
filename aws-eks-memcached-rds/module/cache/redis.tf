data "aws_subnet" "subnet1" {
  id = var.private_subnets[0].id
}

data "aws_subnet" "subnet2" {
  id = var.private_subnets[1].id
}

resource "aws_elasticache_subnet_group" "redis_subnets" {
  name       = "tf-test-cache-subnet"
  subnet_ids = [data.aws_subnet.subnet1.id, data.aws_subnet.subnet2.id]
}
resource "aws_elasticache_cluster" "redis" {
  apply_immediately    = true
  cluster_id           = "${var.env_type}-cluster"
  engine               = "redis"
  node_type            = var.redis_node_type
  num_cache_nodes      = var.redis_num_cache_nodes
  parameter_group_name = "default.redis6.x"
  engine_version       = "6.2"
  port                 = 6379
  subnet_group_name    = aws_elasticache_subnet_group.redis_subnets.name
}