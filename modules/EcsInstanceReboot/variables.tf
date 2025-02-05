variable "create" {
  description = "Whether to create the RAM policy"
  type        = bool
  default     = true
}

variable "policy_name" {
  description = "The name of the policy"
  type        = string
  default     = "EcsInstanceReboot"
}

variable "policy_name_suffix" {
  description = "The suffix to append to the default name of the policy"
  type        = string
  default     = ""
}

variable "description" {
  description = "The description of the policy"
  type        = string
  default     = "Allow to list all ECS instances and reboot specified instances."
}

variable "ecs_instance_ids" {
  description = "The ID of ECS instances, default is all instances"
  type        = list(string)
  default     = ["*"]
}
