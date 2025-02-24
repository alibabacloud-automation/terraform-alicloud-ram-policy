variable "create" {
  description = "Whether to create the RAM policy"
  type        = bool
  default     = true
}

variable "policy_name" {
  description = "The name of the policy"
  type        = string
  default     = "OtsInstanceGetRow"
}

variable "policy_name_suffix" {
  description = "The suffix to append to the default name of the policy"
  type        = string
  default     = ""
}

variable "description" {
  description = "The description of the policy"
  type        = string
  default     = "Allow to query all table data in a specified OTS instance, retrieve single row data, perform batch queries for multiple rows of data, and use secondary indexes for searching."
}

variable "ots_instance" {
  description = "The name of the OTS instance"
  type        = string
}

variable "ots_tables" {
  description = "The names of OTS tables, default is all tables"
  type        = list(string)
  default     = ["*"]
}
