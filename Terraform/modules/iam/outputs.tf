output "ecs_sg_id" {
  value = aws_security_group.Task5-ECS-SG-Zaeem.id
}

output "alb_sg_id" {
  value = aws_security_group.Task5-ALB-SG-Zaeem.id
}

output "efs_sg_id" {
  value = aws_security_group.Task5-EFS-SG-Zaeem.id
}

output "Task5-ecs-task-role-arn" {
  value = aws_iam_role.Task5-ecs-task-role-Zaeem.arn
}

output "Task5-ecs-task-execution-role-arn" {
  value = aws_iam_role.ecs_task_execution_role.arn
}