<!-- BEGIN_TF_DOCS -->
# ☁️ AWS S3 bucket for backup
## Description

This template create S3 bucket for backup
* 🚀 S3
* 🚀 Ownership control
* 🚀 Lifecycle configuration
* 🚀 Intelligent tiering
* 🚀 Server side encription
* 🚀 Bucket Policydocument (Trusted role and bucket owner full control)



## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_archive_archive_days"></a> [archive\_archive\_days](#input\_archive\_archive\_days) | S3 Intelligent-Tiering access tier. Valid values: ARCHIVE\_ACCESS, DEEP\_ARCHIVE\_ACCESS. https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_intelligent_tiering_configuration#access_tier | `number` | `30` | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region to deploy the resources | `string` | n/a | yes |
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | (Optional, Forces new resource) Name of the bucket. If omitted, Terraform will assign a random, unique name. <br>    Must be lowercase and less than or equal to 63 characters in length. A full list of bucket naming rules may be found here.<br>    https://docs.aws.amazon.com/AmazonS3/latest/userguide/bucketnamingrules.html | `string` | n/a | yes |
| <a name="input_deep_archive_access_days"></a> [deep\_archive\_access\_days](#input\_deep\_archive\_access\_days) | S3 Intelligent-Tiering access tier. Valid values: ARCHIVE\_ACCESS, DEEP\_ARCHIVE\_ACCESS. https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_intelligent_tiering_configuration#access_tier | `number` | `60` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment to deploy the resources | `string` | n/a | yes |
| <a name="input_expiration_days"></a> [expiration\_days](#input\_expiration\_days) | Lifetime, in days, of the objects that are subject to the rule. The value must be a non-zero positive integer. https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_lifecycle_configuration#days | `number` | `180` | no |
| <a name="input_object_ownership"></a> [object\_ownership](#input\_object\_ownership) | Object ownership. Valid values: BucketOwnerPreferred, ObjectWriter or BucketOwnerEnforced. https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_ownership_controls#object_ownership | `string` | `"BucketOwnerPreferred"` | no |
| <a name="input_owner"></a> [owner](#input\_owner) | The owner of the deployed resources | `string` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | The project where the resources belongs to | `string` | n/a | yes |
| <a name="input_sse_algorithm"></a> [sse\_algorithm](#input\_sse\_algorithm) | Server-side encryption algorithm to use. Valid values are AES256 and aws:kms https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket#sse_algorithm | `string` | `"AES256"` | no |
| <a name="input_trusted_role_arn"></a> [trusted\_role\_arn](#input\_trusted\_role\_arn) | Backup service role arns | `string` | `"arn:aws:iam::123456789012:role/backup_uploader"` | no |
## Modules

No modules.
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bucket_arn"></a> [bucket\_arn](#output\_bucket\_arn) | The ARN of the S3 bucket. |
| <a name="output_bucket_id"></a> [bucket\_id](#output\_bucket\_id) | The ID of the S3 bucket. |
## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.17.0 |
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.5 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |
## Resources

| Name | Type |
|------|------|
| [aws_s3_bucket.backupbucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_intelligent_tiering_configuration.example-entire-bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_intelligent_tiering_configuration) | resource |
| [aws_s3_bucket_lifecycle_configuration.backupbucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_lifecycle_configuration) | resource |
| [aws_s3_bucket_ownership_controls.backupbucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_ownership_controls) | resource |
| [aws_s3_bucket_policy.allow_access_from_another_account](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_server_side_encryption_configuration.sse_config](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration) | resource |
| [aws_iam_policy_document.allow_access_from_another_account](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
<!-- END_TF_DOCS -->