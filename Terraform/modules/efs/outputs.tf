output "efs_id" {
    description = "EFS File system ID"
    value = aws_efs_file_system.Task5-EFS-Zaeem.id
  
}

output "efs_mpa_id" {
    description = "EFS Mount Point A ID"
    value = aws_efs_mount_target.Task5-EFS-MTa-Zaeem.id
  
}

output "efs_mpb_id" {
    description = "EFS Mount Point B ID"
    value = aws_efs_mount_target.Task5-EFS-MTb-Zaeem.id
  
}

output "ap_arn" {
  description = "EFS Access Point ARN"
  value = aws_efs_access_point.Task5-EFS-AP-Zaeem.arn
}

output "ap_id" {
    description = "ID of the EFS Access Point"
    value = aws_efs_access_point.Task5-EFS-AP-Zaeem.id
  
}