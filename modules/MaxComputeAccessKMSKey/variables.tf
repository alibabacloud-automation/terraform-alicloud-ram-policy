variable "create" {
  description = "Whether to create the RAM policy"
  type        = bool
  default     = true
}

variable "policy_name" {
  description = "The name of the policy"
  type        = string
  default     = "MaxComputeAccessKMSKey"
}

variable "policy_name_suffix" {
  description = "The suffix to append to the default name of the policy"
  type        = string
  default     = ""
}

variable "description" {
  description = "The description of the policy"
  type        = string
  default     = "Allow MaxCompute to encrypt or decrypt with specified KMS key"
}

variable "kms_key_id" {
  description = "The ID of KMS key"
  type        = string
}

variable "kms_key_region" {
  description = "The region ID of KMS key"
  type        = string
  default     = "*"
}

variable "kms_key_account" {
  description = "The account ID of KMS key"
  type        = string
  default     = "*"
}
