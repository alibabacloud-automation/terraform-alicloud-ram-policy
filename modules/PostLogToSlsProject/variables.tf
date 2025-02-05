variable "create" {
  description = "Whether to create the RAM policy"
  type        = bool
  default     = true
}

variable "policy_name" {
  description = "The name of the policy"
  type        = string
  default     = "PostLogToSlsProject"
}

variable "policy_name_suffix" {
  description = "The suffix to append to the default name of the policy"
  type        = string
  default     = ""
}

variable "description" {
  description = "The description of the policy"
  type        = string
  default     = "Allow to post log to specified SLS project"
}

variable "sls_project" {
  description = "The name of the SLS project"
  type        = string
}

variable "sls_logstores" {
  description = "The names of SLS logstores, default is all logstores"
  type        = list(string)
  default     = ["*"]
}
