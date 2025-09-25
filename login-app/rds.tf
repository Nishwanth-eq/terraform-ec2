module "rds" {
  source  = "terraform-aws-modules/rds/aws"
  version = "6.0.0"

  identifier = "login-app-db"
  engine     = "postgres"
  engine_version = "14.5"
  family     = "postgres14"

  instance_class = "db.t4g.micro"
  allocated_storage = 100

  username = var.db_username
  password = var.db_password

  multi_az = true
  subnet_ids = module.vpc.private_subnets

  vpc_security_group_ids = [aws_security_group.rds_sg.id]
}
