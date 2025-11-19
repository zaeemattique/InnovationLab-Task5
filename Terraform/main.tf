module "VPC" {
  source = "./modules/vpc"
  subnet_cidr_A = var.subnet_cidr_A
  subnet_cidr_B = var.subnet_cidr_B
  vpc_cidr = var.vpc_cidr
}

module "IAM" {
  source = "./modules/iam"
  vpc_id = module.VPC.vpc_id
}

module "EFS" {
  source = "./modules/efs"
  posix_usr_guid = var.posix_usr_guid
  posix_usr_uid = var.posix_usr_uid
  owner_gid = var.owner_gid
  owner_uid = var.owner_uid
  efs_file_permission = var.efs_file_permission
  public_subnet_id_A = module.VPC.public_subnet_id_A
  public_subnet_id_B = module.VPC.public_subnet_id_B
  efs_sg_id = module.IAM.efs_sg_id
}

module "ECS" {
  source = "./modules/ecs"
  efs_mpa_id = module.EFS.efs_mpa_id
  efs_mpb_id = module.EFS.efs_mpb_id
  efs_ap_id = module.EFS.ap_id
  efs_id = module.EFS.efs_id
  task_desired_count = var.task_desired_count
  container_name = var.container_name
  public_subnet_id_A = module.VPC.public_subnet_id_A
  public_subnet_id_B = module.VPC.public_subnet_id_B
  tg_arn = module.ALB.tg_arn
  ecs_sg_id = module.IAM.ecs_sg_id
  Task5-ecs-task-role-arn = module.IAM.Task5-ecs-task-role-arn
  Task5-ecs-task-execution-role-arn = module.IAM.Task5-ecs-task-execution-role-arn
}

# module "ECR" {
#   source = "./modules/ecr"
#   ecr_image_tag_mutability = var.ecr_image_tag_mutability
# }

module "ALB" {
  source = "./modules/alb"
  tg_target_type = var.tg_target_type
  public_subnet_id_A = module.VPC.public_subnet_id_A
  public_subnet_id_B = module.VPC.public_subnet_id_B
  vpc_id = module.VPC.vpc_id
  load_balancer_type = var.load_balancer_type
  lb_listener_port = var.lb_listener_port
  lb_listener_protocol = var.lb_listener_protocol
  alb_sg_id = module.IAM.alb_sg_id
}
