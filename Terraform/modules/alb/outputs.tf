output "alb_id" {
    description = "The ID of the ALB"
    value = aws_lb.Task5-ALB-Zaeem.id
  
}

output "tg_id" {
    description = "The ID of the Target Group"
    value = aws_lb_target_group.Task5-TG-Zaeem.id
}

output "tg_arn" {
  description = "ARN of the TG"
  value = aws_lb_target_group.Task5-TG-Zaeem.arn
}