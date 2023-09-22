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
}

variable "number_of_azs"{
    type = number
    description = "number_of_azs"
}

# variable "availability_zones" {
#     type = list(string)
# }