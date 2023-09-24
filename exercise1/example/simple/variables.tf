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
  description = "Additional tag that can be additionally attached to the resource"
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