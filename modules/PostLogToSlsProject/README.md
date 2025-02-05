## Usage

Create a policy that allow to post log to specified SLS project.

```hcl
module "example" {
  source = "terraform-alicloud-modules/ram-policy/alicloud//modules/PostLogToSlsProject"
  sls_project = "prj1"
  sls_logstores = ["logstore1", "logstore2"]
}
```

<!-- 在根目录下运行命令 README.md updated successfully，可将所有信息自动填充 -->
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_alicloud"></a> [alicloud](#requirement\_alicloud) | >= 1.220.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | >= 1.220.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [alicloud_ram_policy.policy](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ram_policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create"></a> [create](#input\_create) | Whether to create the RAM policy | `bool` | `true` | no |
| <a name="input_description"></a> [description](#input\_description) | The description of the policy | `string` | `"Allow to post log to specified SLS project"` | no |
| <a name="input_policy_name"></a> [policy\_name](#input\_policy\_name) | The name of the policy | `string` | `"PostLogToSlsProject"` | no |
| <a name="input_policy_name_suffix"></a> [policy\_name\_suffix](#input\_policy\_name\_suffix) | The suffix to append to the default name of the policy | `string` | `""` | no |
| <a name="input_sls_logstores"></a> [sls\_logstores](#input\_sls\_logstores) | The names of SLS logstores, default is all logstores | `list(string)` | <pre>[<br/>  "*"<br/>]</pre> | no |
| <a name="input_sls_project"></a> [sls\_project](#input\_sls\_project) | The name of the SLS project | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_description"></a> [description](#output\_description) | The description of the policy |
| <a name="output_id"></a> [id](#output\_id) | The policy's ID |
| <a name="output_policy_document"></a> [policy\_document](#output\_policy\_document) | The policy document |
| <a name="output_policy_json"></a> [policy\_json](#output\_policy\_json) | Policy document as json. Useful if you need document but do not want to create IAM policy itself. For example for CloudSSO Permission Set inline policies |
| <a name="output_policy_name"></a> [policy\_name](#output\_policy\_name) | The name of the policy |
<!-- END_TF_DOCS -->
