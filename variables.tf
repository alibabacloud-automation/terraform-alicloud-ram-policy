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

variable "policy_name" {
  description = "Name of the RAM policy"
  type        = string
  default     = ""
}

variable "document" {
  description = "Document of the RAM policy"
  type        = string
  default     = ""
}

variable "description" {
  description = "Description of the RAM policy"
  type        = string
  default     = ""
}

variable "force" {
  description = "This parameter is used for resource destroy"
  type        = bool
  default     = false
}

###########################
# policy-actions
###########################
variable "create" {
  description = "Whether to create a policy"
  type        = bool
  default     = true
}

variable "policy_with_actions" {
  description = "Custom policy action names"
  type        = list(string)
  default     = ["instance-create", "vpc-create", "vswitch-create", "security-group-create"]
}
