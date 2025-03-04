variable "create" {
  description = "Whether to create the RAM policy"
  type        = bool
  default     = true
}

variable "policy_name" {
  description = "The name of the policy"
  type        = string
  default     = "RdsDbInstanceBackup"
}

variable "policy_name_suffix" {
  description = "The suffix to append to the default name of the policy"
  type        = string
  default     = ""
}

variable "description" {
  description = "The description of the policy"
  type        = string
  default     = "Allow to list all RDS instances, create and modify backups for specified instances."
}

variable "rds_dbinstances" {
  description = "The names of RDS dbinstances, default is all dbinstances"
  type        = list(string)
  default     = ["*"]
}
