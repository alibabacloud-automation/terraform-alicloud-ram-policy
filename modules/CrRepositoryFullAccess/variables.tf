variable "create" {
  description = "Whether to create the RAM policy"
  type        = bool
  default     = true
}

variable "policy_name" {
  description = "The name of the policy"
  type        = string
  default     = "CrRepositoryFullAccess"
}

variable "policy_name_suffix" {
  description = "The suffix to append to the default name of the policy"
  type        = string
  default     = ""
}

variable "description" {
  description = "The description of the policy"
  type        = string
  default     = "Allow to full access specified ACR repositories."
}

variable "cr_namespace" {
  description = "The name of ACR namespace"
  type        = string
}

variable "cr_repositories" {
  description = "The list of ACR repository names, default is all repositories"
  type        = list(string)
  default     = ["*"]
}
