# ECS Cluster
resource "aws_ecs_cluster" "stride_cluster" {
  name = "stride-cluster"
}

# Optional: CloudWatch log group for container logs
resource "aws_cloudwatch_log_group" "stride_logs" {
  name              = "/ecs/stride-task"
  retention_in_days = 7
}

# ECS Task Definition
resource "aws_ecs_task_definition" "stride_task" {
  family                   = "stride-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = var.ecs_execution_role
  task_role_arn            = var.ecs_task_role

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }

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
        { name = "FORCE_REVISION", value = "1" }, # Bump this to force task definition update
      ]

      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = aws_cloudwatch_log_group.stride_logs.name
          awslogs-region        = var.region
          awslogs-stream-prefix = "ecs"
        }
      }

      secrets = [
        {
          name      = "SECRET_KEY_BASE"
          valueFrom = data.aws_secretsmanager_secret.rails_secret_key_base.arn
        }
      ]
    }
  ])
}

# ECS Service
resource "aws_ecs_service" "stride_service" {
  name            = "stride-service"
  cluster         = aws_ecs_cluster.stride_cluster.id
  task_definition = aws_ecs_task_definition.stride_task.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  enable_execute_command = true
  network_configuration {
    subnets          = var.public_subnet_ids
    security_groups  = [var.ecs_service_sg_id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.stride_tg.arn
    container_name   = "stride-server"
    container_port   = 3000
  }

  depends_on = [aws_ecs_task_definition.stride_task]

  lifecycle {
    ignore_changes       = [desired_count]
    replace_triggered_by = [aws_ecs_task_definition.stride_task]
  }
}

data "aws_secretsmanager_secret" "rails_secret_key_base" {
  name = "stride/secret_key_base"
}
