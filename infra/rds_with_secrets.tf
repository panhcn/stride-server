# RDS with Secrets Manager Configuration
#
# This Terraform file sets up a PostgreSQL RDS instance with secure credential management
# using AWS Secrets Manager. The configuration includes:
# - Random password generation for database security
# - Secrets Manager integration for secure credential storage
# - RDS PostgreSQL instance configuration with proper networking
# - Outputs the database endpoint for use in other services
#
# The credentials are stored securely and retrieved at runtime, following AWS best practices
# for database credential management.

# Generate a strong random password
resource "random_password" "db_password" {
  length           = 20
  special          = true
  override_special = "!#$%^&*()-_=+[]{}"
}

# Store secret in Secrets Manager
resource "aws_secretsmanager_secret" "rds_secret" {
  name = "rds/stride"
}

resource "aws_secretsmanager_secret_version" "rds_secret_value" {
  secret_id = aws_secretsmanager_secret.rds_secret.id
  secret_string = jsonencode({
    username = var.db_username
    password = random_password.db_password.result
  })
}

# Fetch the latest secret value
data "aws_secretsmanager_secret_version" "rds_secret" {
  secret_id  = aws_secretsmanager_secret.rds_secret.id
  depends_on = [aws_secretsmanager_secret_version.rds_secret_value]
}

# Decode secret into local variables
locals {
  db_credentials = jsondecode(data.aws_secretsmanager_secret_version.rds_secret.secret_string)
}

# Optional: DB Subnet Group (use private subnets ideally)
resource "aws_db_subnet_group" "default" {
  name       = "rds-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = {
    Name = "RDS subnet group"
  }
}

# Create RDS instance
resource "aws_db_instance" "postgres" {
  identifier             = "stride-db"
  engine                 = "postgres"
  engine_version         = "17.2"
  instance_class         = "db.t3.micro"
  allocated_storage      = 20
  db_name                = var.db_name
  username               = local.db_credentials["username"]
  password               = local.db_credentials["password"]
  port                   = 5432
  skip_final_snapshot    = true
  publicly_accessible    = false
  vpc_security_group_ids = [var.db_security_group_id]
  db_subnet_group_name   = aws_db_subnet_group.default.name

  tags = {
    Name = "Postgres-RDS"
  }
}

# Output the endpoint (used in ECS env vars)
output "rds_endpoint" {
  value     = aws_db_instance.postgres.address
  sensitive = true
}
