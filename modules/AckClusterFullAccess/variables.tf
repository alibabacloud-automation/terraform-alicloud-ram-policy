variable "create" {
  description = "Whether to create the RAM policy"
  type        = bool
  default     = true
}

variable "policy_name" {
  description = "The name of the policy"
  type        = string
  default     = "AckClusterFullAccess"
}

variable "policy_name_suffix" {
  description = "The suffix to append to the default name of the policy"
  type        = string
  default     = ""
}

variable "description" {
  description = "The description of the policy"
  type        = string
  default     = "Allow to list and view specified ACK clusters."
}

variable "ack_clusters" {
  description = "The names of ACK clusters, default is all clusters"
  type        = list(string)
  default     = ["*"]
}
