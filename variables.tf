variable "region" {
  description = "The region used to launch this module resources."
  type        = string
  default     = ""
}

variable "profile" {
  description = "The profile name as set in the shared credentials file. If not set, it will be sourced from the ALICLOUD_PROFILE environment variable."
  type        = string
  default     = ""
}
variable "shared_credentials_file" {
  description = "This is the path to the shared credentials file. If this is not set and a profile is specified, $HOME/.aliyun/config.json will be used."
  type        = string
  default     = ""
}

variable "skip_region_validation" {
  description = "Skip static validation of region ID. Used by users of alternative AlibabaCloud-like APIs or users w/ access to regions that are not public (yet)."
  type        = bool
  default     = false
}

variable "create" {
  description = "Whether to create RAM policies. If true, the policies should not be empty."
  type        = bool
  default     = true
}

variable "policies" {
  description = "List Map of known policy actions. Each item can include the following field: `name`(the policy name prefix, default to a name with 'terraform-ram-policy-' prefix), `actions`(list of the custom actions used to create a ram policy), `defined_actions`(list of the defined actions used to create a ram policy), `resources`(list of the resources used to create a ram policy, default to [*]), `effect`(Allow or Deny, default to Allow), `force`(whether to delete ram policy forcibly, default to true)."
  type        = list(map(string))
  default     = []
}