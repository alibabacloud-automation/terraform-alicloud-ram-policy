variable "create" {
  description = "Whether to create the RAM policy"
  type        = bool
  default     = true
}

variable "policy_name" {
  description = "The name of the policy"
  type        = string
  default     = "MnsQueueMsgConsume"
}

variable "policy_name_suffix" {
  description = "The suffix to append to the default name of the policy"
  type        = string
  default     = ""
}

variable "description" {
  description = "The description of the policy"
  type        = string
  default     = "Allow to send to MNS queue, consume from MNS queue, set message visibility, delete messages after consumption."
}

variable "mns_queues" {
  description = "The names of MNS queues, default is all queues"
  type        = list(string)
  default     = ["*"]
}
