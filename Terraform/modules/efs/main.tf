resource "aws_efs_file_system" "Task5-EFS-Zaeem" {
    creation_token = "Task5-EFS-Zaeem"
    performance_mode = "generalPurpose"
    encrypted = true

  tags = {
    Name = "Task5-EFS-Zaeem"
  }
  
}

resource "aws_efs_mount_target" "Task5-EFS-MTa-Zaeem" {
    file_system_id = aws_efs_file_system.Task5-EFS-Zaeem.id
    subnet_id      = var.public_subnet_id_A
    security_groups = [ var.efs_sg_id ]
  
}

resource "aws_efs_mount_target" "Task5-EFS-MTb-Zaeem" {
    file_system_id = aws_efs_file_system.Task5-EFS-Zaeem.id
    subnet_id      = var.public_subnet_id_B
    security_groups = [ var.efs_sg_id ]
  
}

resource "aws_efs_access_point" "Task5-EFS-AP-Zaeem" {
  file_system_id = aws_efs_file_system.Task5-EFS-Zaeem.id
  posix_user {
    uid = var.posix_usr_uid
    gid = var.posix_usr_guid
  }
  root_directory {
    path = "/"
    creation_info {
      owner_gid = var.owner_gid
      owner_uid = var.owner_uid
      permissions = var.efs_file_permission
    }
  }
}