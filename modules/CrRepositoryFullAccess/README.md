# CrRepositoryFullAccess

## Usage

Create a policy that allow to full access specified ACR repositories.

```hcl
module "example" {
  source = "terraform-alicloud-modules/ram-policy/alicloud//modules/CrRepositoryFullAccess"
  cr_namespace = "ns1"
  cr_repositories = ["repo1", "repo2"]
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
| <a name="input_cr_namespace"></a> [cr\_namespace](#input\_cr\_namespace) | The name of ACR namespace | `string` | n/a | yes |
| <a name="input_cr_repositories"></a> [cr\_repositories](#input\_cr\_repositories) | The list of ACR repository names, default is all repositories | `list(string)` | <pre>[<br/>  "*"<br/>]</pre> | no |
| <a name="input_create"></a> [create](#input\_create) | Whether to create the RAM policy | `bool` | `true` | no |
| <a name="input_description"></a> [description](#input\_description) | The description of the policy | `string` | `"Allow to full access specified ACR repositories."` | no |
| <a name="input_policy_name"></a> [policy\_name](#input\_policy\_name) | The name of the policy | `string` | `"CrRepositoryFullAccess"` | no |
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
