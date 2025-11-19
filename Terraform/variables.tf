variable "vpc_cidr" {
    description = "The CIDR block for the VPC"
    type        = string
}


variable "subnet_cidr_A" {
    description = "The CIDR block for the subnet"
    type        = string
}

variable "subnet_cidr_B" {
    description = "The CIDR block for the subnet"
    type        = string
}

variable "load_balancer_type" {
  description = "Type of load balancer"
  type = string
}

variable "lb_listener_port" {
  description = "The port that the LB listens on"
  type = number
}

variable "lb_listener_protocol" {
  description = "The protocol that the LB listens for"
  type = string
}

variable "tg_target_type" {
  description = "Type of Target for the Target Group"
  type = string
}

variable "ecr_image_tag_mutability" {
  description = "Bool value for the mutability of the image tag in the ECR"
  type = string
}

variable "task_desired_count" {
  description = "Desired number of tasks to be at optimum state"
  type = number
}

variable "container_name" {
  description = "The name to be assigned to the container"
  type = string
}

variable "posix_usr_guid" {
  description = "User ID of the posix user group"
  type = number
}

variable "posix_usr_uid" {
  description = "User ID of the posix userr"
  type = number
}

variable "owner_gid" {
  description = "User group ID of the owner of the directory"
  type = number
}

variable "owner_uid" {
  description = "User ID of the owner of the directory"
  type = number
}

variable "efs_file_permission" {
  description = "File permissions for the efs"
  type = number
}


