variable "aws_region" {
    type        = string
    description = "AWS region to deploy the resources"
}

variable "environment" {
    type = string
    description = "The environment to deploy the resources"
}

variable "owner" {
    type = string
    description = "The owner of the deployed resources"
}

variable "project" {
    type = string
    description = "The project where the resources belongs to"
}

variable "additional_tag" {
    type = string
    description = "Additional tag that can be additionally attached to the resource"
    default = ""
}

variable "cidr_block" {
    type = string
    description = "The IPv4 CIDR block for the VPC. CIDR can be explicitly set or it can be derived from IPAM using"
    default = "10.0.0.0/16"
}

variable "instance_tenancy" {
    type = string
    description = <<EOF
    A tenancy option for instances launched into the VPC.
    Default is default, which ensures that EC2 instances launched in this VPC use the EC2 instance tenancy attribute specified when the EC2 instance is launched.
    The only other option is dedicated, which ensures that EC2 instances launched in this VPC are run on dedicated tenancy instances regardless of the tenancy attribute specified at launch.
    This has a dedicated per region fee of $2 per hour, plus an hourly per instance usage fee.    
EOF
    default = "default"
    validation {
        condition = var.instance_tenancy == "default" || var.instance_tenancy == "dedicated"
        error_message = "The instance_tenancy variable's value must be default or dedicated. https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc#instance_tenancy"
    }
}

variable "availability_zones" {
    type    = list(string)
    nullable = true
    default = null
}

variable "number_of_azs"{
    type = number
    default = 2
    description = "number_of_azs"
}

locals {
  azs_to_use = var.availability_zones == null ? slice(sort(data.aws_availability_zones.available.zone_ids), 0, var.number_of_azs) : var.availability_zones
}

