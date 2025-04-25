resource "aws_iam_policy" "ecs_secrets_access" {
  name = "ecs-secrets-access"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "secretsmanager:GetSecretValue"
        ],
        Resource = data.aws_secretsmanager_secret.rails_secret_key_base.arn
      }
    ]
  })
}

resource "aws_iam_policy" "ecs_task_ssm_exec" {
  name        = "ecs-task-ssm-exec"
  description = "Allow ECS Exec via SSM from task containers"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "ssmmessages:CreateControlChannel",
          "ssmmessages:CreateDataChannel",
          "ssmmessages:OpenControlChannel",
          "ssmmessages:OpenDataChannel"
        ],
        Resource = "*"
      }
    ]
  })
}


resource "aws_iam_role_policy_attachment" "ecs_exec_attach_secrets" {
  role       = var.ecs_execution_role_name
  policy_arn = aws_iam_policy.ecs_secrets_access.arn
}

resource "aws_iam_role_policy_attachment" "ecs_exec_attach_ssm" {
  role       = var.ecs_task_role_name
  policy_arn = aws_iam_policy.ecs_task_ssm_exec.arn
}
