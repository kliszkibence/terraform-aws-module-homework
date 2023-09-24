variable "aws_region" {
  type        = string
  description = "AWS region to deploy the resources"
  validation {
    condition     = can(regex("^[a-z]+-[a-z]+-[0-9]+$", var.aws_region))
    error_message = "Invalid AWS region format. https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Concepts.RegionsAndAvailabilityZones.html"
  }
}

variable "environment" {
  type        = string
  description = "The environment to deploy the resources"
}

variable "owner" {
  type        = string
  description = "The owner of the deployed resources"
}

variable "project" {
  type        = string
  description = "The project where the resources belongs to"
}

variable "additional_tag" {
  type        = string
  description = "Example of an additional tag that can be additionally attached to the resource nex to the tag set."
  default     = ""
}

variable "cidr_block" {
  type        = string
  description = "The IPv4 CIDR block for the VPC. CIDR can be explicitly set or it can be derived from IPAM using"
  default     = "10.0.0.0/16"
  validation {
    condition     = can(cidrhost(var.cidr_block, 0))
    error_message = "Must be valid IPv4 CIDR. https://docs.aws.amazon.com/vpc/latest/userguide/vpc-cidr-blocks.html"
  }
}

variable "instance_tenancy" {
  type        = string
  description = <<EOF
    A tenancy option for instances launched into the VPC.
    Default is default, which ensures that EC2 instances launched in this VPC use the EC2 instance tenancy attribute specified when the EC2 instance is launched.
    The only other option is dedicated, which ensures that EC2 instances launched in this VPC are run on dedicated tenancy instances regardless of the tenancy attribute specified at launch.
    This has a dedicated per region fee of $2 per hour, plus an hourly per instance usage fee.    
EOF
  default     = "default"
  validation {
    condition     = can(regex("^(default|dedicated)$", var.instance_tenancy))
    error_message = "The instance_tenancy variable's value must be default or dedicated. https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc#instance_tenancy"
  }
}

variable "availability_zones" {
  type        = list(string)
  nullable    = true
  default     = null
  description = <<EOF
    List of the Availability Zones where subnets are deployed.
    https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Concepts.RegionsAndAvailabilityZones.html
EOF
}

variable "number_of_azs" {
  type        = number
  default     = 2
  description = <<EOF
    Number of Availability Zones where subnets have to be deployed. Number should be between 1 and 6.
    https://aws.amazon.com/about-aws/global-infrastructure/regions_az/
EOF
  validation {
    condition     = var.number_of_azs >= 1 && var.number_of_azs <= 6
    error_message = "Accepted values: 1-6"
  }
}

locals {
  azs_to_use = var.availability_zones == null ? slice(sort(data.aws_availability_zones.available.zone_ids), 0, var.number_of_azs) : var.availability_zones
}

