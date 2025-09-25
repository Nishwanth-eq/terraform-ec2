resource "aws_elasticache_subnet_group" "redis" {
  name       = "login-app-redis-subnet"
  subnet_ids = module.vpc.private_subnets
}

resource "aws_elasticache_replication_group" "redis" {
  replication_group_id       = "login-app-redis"
  description                = "Redis for login app"
  node_type                  = "cache.t3.medium"
  num_cache_clusters         = 3
  automatic_failover_enabled = true
  multi_az_enabled           = true
  subnet_group_name          = aws_elasticache_subnet_group.redis.name
  security_group_ids         = [aws_security_group.redis_sg.id]
}
