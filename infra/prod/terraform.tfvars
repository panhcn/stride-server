# Production environment Terraform variables for Stride Server
# These variables are used to configure the production AWS infrastructure

# AWS region where all resources will be deployed
region = "us-west-2"

# Name of the production database
db_name = "stride_production"

# Username for database access
db_username = "stride_server"

# Docker image URL for the Rails application in ECR
rails_image_url = "315183407242.dkr.ecr.us-west-2.amazonaws.com/stride-server:latest"

# IAM role that grants ECS permission to pull images and write logs
ecs_execution_role = "arn:aws:iam::315183407242:role/ecsTaskExecutionRole"
# IAM role that the application assumes when running
ecs_task_role = "arn:aws:iam::315183407242:role/ecsTaskAppRole"

# Public subnets for resources that need public internet access
vpc_id = "vpc-04b2aaa8413db70b3"
public_subnet_ids = [
  "subnet-0a696205e8869d771", # us-west-2a
  "subnet-027c39086df14b8de"  # us-west-2c
]

# Private subnets for resources that don't need direct internet access
private_subnet_ids = [
  "subnet-04620c291410c582d", # us-west-2b
  "subnet-0a034a82e89e86b33"  # us-west-2d
]

# Security group for ECS service (must allow outbound to RDS, inbound on port 3000 if ALB)
ecs_service_sg_id = "sg-005a382efe9844d84" # 🔁 replace

# Security group for RDS (must allow inbound from ECS SG on port 5432)
db_security_group_id = "sg-0d09fe954daf698bd" # 🔁 replace
