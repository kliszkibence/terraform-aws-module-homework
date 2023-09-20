output "aws_vpc_id" {
    value = module.vpc.aws_vpc_id
    description = "The VPC ID: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc#id"
}

output "aws_vpc_arn" {
    value = module.aws_vpc_arn
    description = "Amazon Resource Name (ARN) of VPC: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc#arn"
}