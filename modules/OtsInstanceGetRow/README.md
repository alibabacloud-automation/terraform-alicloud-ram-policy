## Usage

Create a policy that allow to query all table data in a specified OTS instance, retrieve single row data, perform batch queries for multiple rows of data, and use secondary indexes for searching.

```hcl
module "example" {
  source = "terraform-alicloud-modules/ram-policy/alicloud//modules/OtsInstanceGetRow"
  ots_instance = "inst1"
  ots_tables = ["tbl1", "tbl2"]
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
| <a name="input_description"></a> [description](#input\_description) | The description of the policy | `string` | `"Allow to query all table data in a specified OTS instance, retrieve single row data, perform batch queries for multiple rows of data, and use secondary indexes for searching."` | no |
| <a name="input_ots_instance"></a> [ots\_instance](#input\_ots\_instance) | The name of the OTS instance | `string` | n/a | yes |
| <a name="input_ots_tables"></a> [ots\_tables](#input\_ots\_tables) | The names of OTS tables, default is all tables | `list(string)` | <pre>[<br/>  "*"<br/>]</pre> | no |
| <a name="input_policy_name"></a> [policy\_name](#input\_policy\_name) | The name of the policy | `string` | `"OtsInstanceGetRow"` | no |
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
