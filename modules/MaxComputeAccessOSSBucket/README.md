# MaxComputeAccessOSSBucket

## Usage

Create a policy that allow MaxCompute to access specified OSS Bucket.

```hcl
module "example" {
  source = "terraform-alicloud-modules/ram-policy/alicloud//modules/MaxComputeAccessOSSBucket"
  oss_bucket_name = "bkt1"
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [alicloud_ram_policy.policy](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/ram_policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create"></a> [create](#input\_create) | Whether to create the RAM policy | `bool` | `true` | no |
| <a name="input_description"></a> [description](#input\_description) | The description of the policy | `string` | `"Allow MaxCompute to access specified OSS Bucket"` | no |
| <a name="input_oss_bucket_name"></a> [oss\_bucket\_name](#input\_oss\_bucket\_name) | The name of the bucket | `string` | n/a | yes |
| <a name="input_policy_name"></a> [policy\_name](#input\_policy\_name) | The name of the policy | `string` | `"MaxComputeAccessOSSBucket"` | no |
| <a name="input_policy_name_suffix"></a> [policy\_name\_suffix](#input\_policy\_name\_suffix) | The suffix to append to the default name of the policy | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_description"></a> [description](#output\_description) | The description of the policy |
| <a name="output_id"></a> [id](#output\_id) | The policy's ID |
| <a name="output_policy_document"></a> [policy\_document](#output\_policy\_document) | The policy document |
| <a name="output_policy_json"></a> [policy\_json](#output\_policy\_json) | Policy document as json. Useful if you need document but do not want to create IAM policy itself. For example for CloudSSO Permission Set inline policies |
| <a name="output_policy_name"></a> [policy\_name](#output\_policy\_name) | The name of the policy |
<!-- END_TF_DOCS -->
