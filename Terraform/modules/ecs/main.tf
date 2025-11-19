resource "aws_ecs_cluster" "Task5-ECS-Cluster-Zaeem" {
  name = "Task5-ECS-Cluster-Zaeem"
  
}

resource "aws_ecs_task_definition" "Task5-TaskDefinition" {
  depends_on = [ var.efs_id ]
  family = "Task5-Zaeem"
  task_role_arn = var.Task5-ecs-task-role-arn
  execution_role_arn = var.Task5-ecs-task-execution-role-arn
  requires_compatibilities = ["FARGATE"]
  network_mode = "awsvpc" 
  cpu = "256"
  memory = "512"
  container_definitions = jsonencode([
    {
      name      = "NginxServer"
      image     = "504649076991.dkr.ecr.us-west-2.amazonaws.com/zaeem/task5:latest"
      # cpu       = 256
      # memory    = 512
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
      
        }
      ]
      mountPoints = [
        {
          sourceVolume = "Task5-EFS-Zaeem"
          containerPath = "/mnt/data"

        }
      ]
    }
  ])

  volume {
    name = "Task5-EFS-Zaeem"

    efs_volume_configuration {
      file_system_id          = var.efs_id
      root_directory          = "/"
      transit_encryption      = "ENABLED"
      transit_encryption_port = 2999
      authorization_config {
        access_point_id = var.efs_ap_id
        iam             = "ENABLED"
      }
    }
  }

}

resource "aws_ecs_service" "Task5-ECS-Service-Zaeem" {
  name            = "Task5-ECS-Service-Zaeem"
  cluster         = aws_ecs_cluster.Task5-ECS-Cluster-Zaeem.id
  task_definition = aws_ecs_task_definition.Task5-TaskDefinition.arn
  desired_count   = var.task_desired_count
  launch_type = "FARGATE"
  
  load_balancer {
    target_group_arn = var.tg_arn
    container_name = var.container_name
    container_port = 80
  }
  

  network_configuration {
    subnets         = [var.public_subnet_id_A, var.public_subnet_id_B]
    security_groups = [var.ecs_sg_id]
    assign_public_ip = true
  }
  
}
