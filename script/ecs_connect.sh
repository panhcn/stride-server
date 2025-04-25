#!/bin/bash

set -euo pipefail

CLUSTER="stride-cluster"
SERVICE="stride-service"
CONTAINER="stride-server"
COMMAND="${1:-/bin/bash}"

echo "🔍 Looking for latest task in service '$SERVICE' on cluster '$CLUSTER'..."

TASK_ARN=$(aws ecs list-tasks \
  --cluster "$CLUSTER" \
  --service-name "$SERVICE" \
  --desired-status RUNNING \
  --query 'taskArns[0]' \
  --output text)

if [[ "$TASK_ARN" == "None" || -z "$TASK_ARN" ]]; then
  echo "❌ No running ECS task found for service '$SERVICE'."
  exit 1
fi

echo "✅ Found task: $TASK_ARN"
echo "🔐 Starting ECS Exec session into container '$CONTAINER'..."

aws ecs execute-command \
  --cluster "$CLUSTER" \
  --task "$TASK_ARN" \
  --container "$CONTAINER" \
  --interactive \
  --command "$COMMAND"