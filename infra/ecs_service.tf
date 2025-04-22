# This file defines the ECS resources for the Stride application
# It includes the ECS cluster, task definition, and service configuration
# The service runs a containerized Rails application in AWS Fargate

resource "aws_ecs_cluster" "stride_cluster" {
  name = "stride-cluster"
}

resource "aws_ecs_task_definition" "stride_task" {
  family                   = "stride-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = var.ecs_execution_role
  task_role_arn            = var.ecs_task_role

  container_definitions = jsonencode([
    {
      name      = "stride-server"
      image     = var.rails_image_url
      essential = true
      portMappings = [
        {
          containerPort = 3000
          protocol      = "tcp"
        }
      ]
      environment = [
        { name = "RAILS_ENV", value = "production" },
        { name = "DB_NAME", value = var.db_name },
        { name = "DB_USERNAME", value = local.db_credentials["username"] },
        { name = "DB_PASSWORD", value = local.db_credentials["password"] },
        { name = "DB_HOST", value = aws_db_instance.postgres.address },
      ]
    }
  ])
}

resource "aws_ecs_service" "stride_service" {
  name            = "stride-service"
  cluster         = aws_ecs_cluster.stride_cluster.id
  task_definition = aws_ecs_task_definition.stride_task.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = var.public_subnet_ids
    security_groups  = [var.ecs_service_sg_id]
    assign_public_ip = true
  }
}
