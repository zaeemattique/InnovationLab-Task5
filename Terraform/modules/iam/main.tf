resource "aws_security_group" "Task5-ALB-SG-Zaeem" {
  name        = "Task5-ALB-SG-Zaeem"
  vpc_id      = var.vpc_id

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  tags = {
    Name = "Task5-ALB-SG-Zaeem"
  }
}

resource "aws_security_group" "Task5-EFS-SG-Zaeem" {
  name        = "Task5-EFS-SG-Zaeem"
  vpc_id      = var.vpc_id
  
  ingress {
    from_port = 2049
    to_port = 2049
    protocol = "tcp"
    security_groups = [ aws_security_group.Task5-ECS-SG-Zaeem.id ]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  tags = {
    Name = "Task5-EFS-SG-Zaeem"
  }
}

resource "aws_security_group" "Task5-ECS-SG-Zaeem" {
  name        = "Task5-ECS-SG-Zaeem"
  vpc_id      = var.vpc_id
  
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    security_groups = [ aws_security_group.Task5-ALB-SG-Zaeem.id ]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  tags = {
    Name = "Task5-ECS-SG-Zaeem"
  }
}

resource "aws_iam_role" "Task5-ecs-task-role-Zaeem" {
  name = "Task5-ecs-task-role-Zaeem"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy" "Task5-ecs-task-role-policy-Zaeem" {
  name = "Task5-ecs-task-role-policy-Zaeem"
  role = aws_iam_role.Task5-ecs-task-role-Zaeem.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "elasticfilesystem:ClientRootAccess",
          "elasticfilesystem:ClientWrite",
          "elasticfilesystem:ClientMount"
        ]
        Resource = "*"
      }
    ]
  })
}


resource "aws_iam_role" "ecs_task_execution_role" {
  name = "ecsTaskExecutionRoleZaeem"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_execution_role_policy" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}