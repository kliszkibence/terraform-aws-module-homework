<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.5 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_vpc"></a> [vpc](#module\_vpc) | ../.. | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_tag"></a> [additional\_tag](#input\_additional\_tag) | Additional tag that can be additionally attached to the resource | `string` | n/a | yes |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region to deploy the resources | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment to deploy the resources | `string` | n/a | yes |
| <a name="input_number_of_azs"></a> [number\_of\_azs](#input\_number\_of\_azs) | Number of Availability Zones where subnets have to be deployed. Number should be between 1 and 6.<br>    https://aws.amazon.com/about-aws/global-infrastructure/regions_az/ | `number` | `2` | no |
| <a name="input_owner"></a> [owner](#input\_owner) | The owner of the deployed resources | `string` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | The project where the resources belongs to | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_vpc_arn"></a> [aws\_vpc\_arn](#output\_aws\_vpc\_arn) | Amazon Resource Name (ARN) of VPC: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc#arn |
| <a name="output_aws_vpc_id"></a> [aws\_vpc\_id](#output\_aws\_vpc\_id) | The VPC ID: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc#id |
<!-- END_TF_DOCS -->