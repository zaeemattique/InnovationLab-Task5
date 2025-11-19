variable "public_subnet_id_A" {
  description = "The ID of the public subnet"
}

variable "public_subnet_id_B" {
  description = "The ID of the public subnet"
}

variable "efs_sg_id" {
  description = "The ID of the SG for EFS"
}

variable "posix_usr_guid" {
  description = "User ID of the posix user group"
}

variable "posix_usr_uid" {
  description = "User ID of the posix userr"
}

variable "owner_gid" {
  description = "User group ID of the owner of the directory"
}

variable "owner_uid" {
  description = "User ID of the owner of the directory"
}

variable "efs_file_permission" {
  description = "File permissions for the efs"
}