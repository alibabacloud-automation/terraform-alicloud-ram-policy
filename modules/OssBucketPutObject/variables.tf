variable "create" {
  description = "Whether to create the RAM policy"
  type        = bool
  default     = true
}

variable "policy_name" {
  description = "The name of the policy"
  type        = string
  default     = "OssBucketPutObject"
}

variable "policy_name_suffix" {
  description = "The suffix to append to the default name of the policy"
  type        = string
  default     = ""
}

variable "description" {
  description = "The description of the policy"
  type        = string
  default     = "Allow to put and get objects to/from specified OSS Bucket, with no permission to delete, suitable for file upload and download scenarios."
}

variable "oss_bucket_name" {
  description = "The name of OSS bucket"
  type        = string
}
