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

variable "description" {
  description = "Description of the RAM policy"
  type        = string
  default     = "Custom Policy for precise resource control"
}

variable "force" {
  description = "This parameter is used for resource destroy"
  type        = bool
  default     = true
}

###########################
# policy-actions
###########################
variable "create" {
  description = "Whether to create RAM policies. If true, the policies should not be empty."
  type        = bool
  default     = true
}

###########################
# policy-block
###########################
variable "policies" {
  description = "Parameter set used to define Policy, including `name`,` actions`, `defined_actions`,` resources`,` force`"
  type        = list(map(string))
}