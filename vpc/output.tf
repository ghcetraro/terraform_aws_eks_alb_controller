#
output "vpc_main_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}
#
output "vpc_main_cidr_block" {
  value = var.vpc_main.cidr_block
}
#