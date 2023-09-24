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

variable "bucket_name" {
  type        = string
  description = <<EOF
    (Optional, Forces new resource) Name of the bucket. If omitted, Terraform will assign a random, unique name. 
    Must be lowercase and less than or equal to 63 characters in length. A full list of bucket naming rules may be found here.
    https://docs.aws.amazon.com/AmazonS3/latest/userguide/bucketnamingrules.html
EOF
  validation {
    condition     = can(regex("^([a-z0-9]{1}[a-z0-9-]{1,61}[a-z0-9]{1})$", var.bucket_name))
    error_message = "Invalid bucket name, please check https://docs.aws.amazon.com/AmazonS3/latest/userguide/bucketnamingrules.html for more details."
  }
}

variable "expiration_days" {
  type        = number
  description = "Lifetime, in days, of the objects that are subject to the rule. The value must be a non-zero positive integer. https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_lifecycle_configuration#days"
  default     = 180
  validation {
    condition     = var.expiration_days > 0
    error_message = "Lifetime, in days, of the objects that are subject to the rule. The value must be a non-zero positive integer. https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_lifecycle_configuration#days"
  }
}

variable "object_ownership" {
  type        = string
  description = "Object ownership. Valid values: BucketOwnerPreferred, ObjectWriter or BucketOwnerEnforced. https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_ownership_controls#object_ownership"
  default     = "BucketOwnerPreferred"
  validation {
    condition     = can(regex("^(BucketOwnerPreferred|ObjectWriter|BucketOwnerEnforced)$", var.object_ownership))
    error_message = "Object ownership. Valid values: BucketOwnerPreferred, ObjectWriter or BucketOwnerEnforced. https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_ownership_controls#object_ownership"
  }
}

variable "archive_access_days" {
  type        = number
  description = "Number of consecutive days of no access after which an object will be eligible to be transitioned to the corresponding tier. https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_intelligent_tiering_configuration#access_tier"
  default     = 91
  validation {
    condition     = var.archive_access_days > 90
    error_message = "S3 Intelligent-Tiering moves objects that have not been accessed for a minimum of 90 consecutive days. https://docs.aws.amazon.com/AmazonS3/latest/userguide/intelligent-tiering-overview.html"
  }
}

variable "sse_algorithm" {
  type        = string
  description = "Server-side encryption algorithm to use. Valid values are AES256 and aws:kms https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket#sse_algorithm"
  default     = "AES256"
  validation {
    condition     = can(regex("^(AES256|aws:kms)$", var.sse_algorithm))
    error_message = "Server-side encryption algorithm to use. Valid values are AES256 and aws:kms https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket#sse_algorithm"
  }
}

variable "trusted_role_arn" {
  type        = string
  description = "Backup service role arn"
  default     = "arn:aws:iam::123456789012:role/backup_uploader"
  validation {
    condition     = can(regex("^arn:aws:iam::[0-9]{12}:role/[a-zA-Z\\-\\_0-9]{1,64}$", var.trusted_role_arn))
    error_message = "Role name should be 1-64 char of of upper and lowercase alphanumeric characters with no spaces. You can also include any of the following characters: _+=,.@- See RoleName section: https://docs.aws.amazon.com/IAM/latest/APIReference/API_CreateRole.html"
  }
}