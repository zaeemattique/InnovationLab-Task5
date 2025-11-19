output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.Task5-vpc-zaeem.id
}

output "public_subnet_id_A" {
  description = "The ID of the public subnet"
  value       = aws_subnet.Task5-publicSNA-zaeem.id
}

output "public_subnet_id_B" {
  description = "The ID of the public subnet"
  value       = aws_subnet.Task5-publicSNB-zaeem.id
}

output "internet_gateway_id" {
  description = "The ID of the internet gateway"
  value       = aws_internet_gateway.Task5-igw-zaeem.id
}

output "public_route_table_id" {
  description = "The ID of the public route table"
  value       = aws_route_table.Task5-publicRT-zaeem.id
}