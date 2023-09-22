provider "aws" {
    region = var.aws_region
}

module "vpc" {
    source = "../.."
    aws_region = var.aws_region
    environment = var.environment
    owner = var.owner
    project = var.project
    number_of_azs = var.number_of_azs
    # availability_zones = var.availability_zones
}