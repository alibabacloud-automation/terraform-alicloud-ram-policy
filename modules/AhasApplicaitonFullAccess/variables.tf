variable "create" {
  description = "Whether to create the RAM policy"
  type        = bool
  default     = true
}

variable "policy_name" {
  description = "The name of the policy"
  type        = string
  default     = "AhasApplicaitonFullAccess"
}

variable "policy_name_suffix" {
  description = "The suffix to append to the default name of the policy"
  type        = string
  default     = ""
}

variable "description" {
  description = "The description of the policy"
  type        = string
  default     = "Allow to access specified AHAS applications and authorize AHAS."
}

variable "ahas_namespace" {
  description = "The name of AHAS namespace"
  type        = string
}

variable "ahas_applications" {
  description = "The list of AHAS application names, default is all applications"
  type        = list(string)
  default     = ["*"]
}
