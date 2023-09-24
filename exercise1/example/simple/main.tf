provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source         = "../.."
  aws_region     = var.aws_region
  environment    = var.environment
  owner          = var.owner
  project        = var.project
  additional_tag = var.additional_tag
  number_of_azs  = var.number_of_azs
}