output "vpc_id" {
  description = "Id da vpc"
  value       = aws_vpc.vpc.id
}

output "subnet_ids" {
  description = "Lista de subnets"
  value       = aws_subnet.subnets[*].id

}
