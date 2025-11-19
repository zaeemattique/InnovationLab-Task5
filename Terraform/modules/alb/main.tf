resource "aws_lb" "Task5-ALB-Zaeem" {
  name               = "Task5-ALB-Zaeem"
  internal           = false
  load_balancer_type = var.load_balancer_type
  security_groups    = [var.alb_sg_id]
  subnets            = [var.public_subnet_id_A, var.public_subnet_id_B]

  enable_deletion_protection = false

}

resource "aws_lb_target_group" "Task5-TG-Zaeem" {
  name        = "Task5-TG-Zaeem"
  port        = 80
  protocol    = "HTTP"
  target_type = var.tg_target_type
  vpc_id      = var.vpc_id
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.Task5-ALB-Zaeem.arn
  port              = var.lb_listener_port
  protocol          = var.lb_listener_protocol

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.Task5-TG-Zaeem.arn
  }
}