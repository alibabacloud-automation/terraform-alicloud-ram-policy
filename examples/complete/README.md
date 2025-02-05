# complete example

Configuration in this directory will create custom policies on Alibaba Cloud.


## Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Note that this example will create resources which cost money. Run `terraform destroy` when you don't need these resources.

<!-- 在根目录下运行命令 `terraform-docs markdown . --output-file "./README.md"`，可将所有信息自动填充 -->
<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_policy"></a> [policy](#module\_policy) | ../../ | n/a |
| <a name="module_policy2"></a> [policy2](#module\_policy2) | ../../ | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ecs_defined_actions"></a> [ecs\_defined\_actions](#input\_ecs\_defined\_actions) | ecs defined actions used to create a ram policy | `string` | `"instance-all,vpc-all,vswitch-all,security-group-all,security-group-rule-all"` | no |
| <a name="input_effect"></a> [effect](#input\_effect) | This parameter indicates whether or not the action is allowed. Valid values are Allow and Deny | `string` | `"Allow"` | no |
| <a name="input_force"></a> [force](#input\_force) | This parameter is used for resource destroy. Default value is false | `string` | `false` | no |
| <a name="input_oss_bucket_actions"></a> [oss\_bucket\_actions](#input\_oss\_bucket\_actions) | oss bucket custom actions used to create a ram policy | `string` | `"oss:PutBucket*,SetBucket,GetBucket*,DeleteBucket*"` | no |
| <a name="input_oss_bucket_resources"></a> [oss\_bucket\_resources](#input\_oss\_bucket\_resources) | the resources used to create a ram policy of oss bucket, default to [*] | `string` | `"acs:oss:*:*:*"` | no |
| <a name="input_slb_eip_actions"></a> [slb\_eip\_actions](#input\_slb\_eip\_actions) | slb eip custom actions used to create a ram policy | `string` | `"vpc:AssociateEipAddress, vpc:UnassociateEipAddress"` | no |
| <a name="input_slb_eip_defined_actions"></a> [slb\_eip\_defined\_actions](#input\_slb\_eip\_defined\_actions) | slb eip defined actions used to create a ram policy | `string` | `"slb-all,vpc-all,vswitch-all"` | no |
| <a name="input_slb_eip_resources"></a> [slb\_eip\_resources](#input\_slb\_eip\_resources) | the resources used to create a ram policy of slb eip, default to [*] | `string` | `"acs:vpc:*:*:eip/eip-12345,acs:slb:*:*:*"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_policy_id"></a> [policy\_id](#output\_policy\_id) | id of the custom policy. |
| <a name="output_policy_name"></a> [policy\_name](#output\_policy\_name) | Name of the custom policy. |
<!-- END_TF_DOCS -->
