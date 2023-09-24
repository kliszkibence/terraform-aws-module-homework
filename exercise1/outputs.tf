output "aws_vpc_id" {
  value       = aws_vpc.main.id
  description = "The ID of the VPC"
}

output "aws_vpc_arn" {
  value       = aws_vpc.main.arn
  description = "Amazon Resource Name (ARN) of VPC"
}
