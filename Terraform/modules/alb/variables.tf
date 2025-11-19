variable "alb_sg_id" {
  description = "ALB Security Group ID"
}

variable "public_subnet_id_A" {
  description = "The ID of the public subnet"
}

variable "public_subnet_id_B" {
  description = "The ID of the public subnet"
}

variable "vpc_id" {
    description = "The ID of the VPC"
  
}

variable "load_balancer_type" {
  description = "Type of load balancer"
}

variable "lb_listener_port" {
  description = "The port that the LB listens on"
}

variable "lb_listener_protocol" {
  description = "The protocol that the LB listens for"
}

variable "tg_target_type" {
  description = "Type of Target for the Target Group"
}
