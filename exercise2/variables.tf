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

variable "bucket_name" {
    type = string
    description = <<EOF
    (Optional, Forces new resource) Name of the bucket. If omitted, Terraform will assign a random, unique name. 
    Must be lowercase and less than or equal to 63 characters in length. A full list of bucket naming rules may be found here.
    https://docs.aws.amazon.com/AmazonS3/latest/userguide/bucketnamingrules.html
EOF
}

variable "expiration_days" {
    type = number
    description = " Lifetime, in days, of the objects that are subject to the rule. The value must be a non-zero positive integer. https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_lifecycle_configuration#days"
    default = 180
}

variable "object_ownership" {
    type = string
    description = "Object ownership. Valid values: BucketOwnerPreferred, ObjectWriter or BucketOwnerEnforced. https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_ownership_controls#object_ownership"
    default = "BucketOwnerPreferred"
}

variable "archive_archive_days" {
    type = number
    description = "S3 Intelligent-Tiering access tier. Valid values: ARCHIVE_ACCESS, DEEP_ARCHIVE_ACCESS. https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_intelligent_tiering_configuration#access_tier"
    default = 91
}

variable "sse_algorithm" {
    type = string
    description = "Server-side encryption algorithm to use. Valid values are AES256 and aws:kms https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket#sse_algorithm"
    default = "AES256"
}

variable "trusted_role_arn" {
    type = string
    description = "Backup service role arns"
    default = "arn:aws:iam::123456789012:role/backup_uploader"
}

# locals {
#     trusted_role_arn = "arn:aws:iam::123456789012:role/backup_uploader"
# }

# locals {
#     trusted_role_arns = [
#         local. somthing 
#     ]
# }