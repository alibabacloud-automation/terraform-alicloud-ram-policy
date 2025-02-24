variable "create" {
  description = "Whether to create the RAM policy"
  type        = bool
  default     = true
}

variable "policy_name" {
  description = "The name of the policy"
  type        = string
  default     = "OssBucketReadOnly"
}

variable "policy_name_suffix" {
  description = "The suffix to append to the default name of the policy"
  type        = string
  default     = ""
}

variable "description" {
  description = "The description of the policy"
  type        = string
  default     = "Allow to access resources of specified OSS bucket."
}

variable "oss_bucket_name" {
  description = "The name of OSS bucket"
  type        = string
}

variable "oss_object_names" {
  description = "The names of OSS objects, default is all objects"
  type        = list(string)
  default     = ["*"]
}
