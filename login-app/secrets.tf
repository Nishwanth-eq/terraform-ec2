resource "aws_secretsmanager_secret" "db" {
  name        = "login-app-db-credentials"
  description = "DB creds for login app"
}

resource "aws_secretsmanager_secret_version" "db" {
  secret_id     = aws_secretsmanager_secret.db.id
  secret_string = jsonencode({ username = var.db_username, password = var.db_password })
}
