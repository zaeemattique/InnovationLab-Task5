variable "efs_id" {
    description = "EFS File system ID"
  
}

variable "efs_mpa_id" {
    description = "EFS Mount Point A ID"
  
}

variable "efs_mpb_id" {
    description = "EFS Mount Point B ID"
  
}

variable "efs_ap_id" {
    description = "ID of the EFS access point"
  
}

variable "public_subnet_id_A" {
  description = "The ID of the public subnet"

}

variable "public_subnet_id_B" {
  description = "The ID of the public subnet"

}

variable "ecs_sg_id" {
  description = "The ID of the SG for ECS"
}

variable "tg_arn" {
  description = "ARN of the TG"
}

variable "task_desired_count" {
  description = "Desired number of tasks to be at optimum state"
}

variable "container_name" {
  description = "The name to be assigned to the container"
}

variable "Task5-ecs-task-role-arn" {
  description = "ARN for the task role for efs"
}

variable "Task5-ecs-task-execution-role-arn" {
  description = "ARN for the task execution role"
}