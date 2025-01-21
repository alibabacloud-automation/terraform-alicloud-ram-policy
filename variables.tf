variable "create" {
  description = "(Deprecated) Whether to create RAM policies. If true, the policies should not be empty."
  type        = bool
  default     = true
}

variable "policies" {
  description = "(Deprecated, use alicloud_ram_policy_document data source instead) List Map of known policy actions. Each item can include the following field: `name`(the policy name prefix, default to a name with 'terraform-ram-policy-' prefix), `actions`(list of the custom actions used to create a ram policy), `defined_actions`(list of the defined actions used to create a ram policy), `resources`(list of the resources used to create a ram policy, default to [*]), `effect`(Allow or Deny, default to Allow), `force`(whether to delete ram policy forcibly, default to true)."
  type        = list(map(string))
  default     = []
}
