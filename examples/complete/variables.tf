variable "ecs_defined_actions" {
  description = "ecs defined actions used to create a ram policy"
  type        = string
  default     = "instance-all,vpc-all,vswitch-all,security-group-all,security-group-rule-all"
}

variable "effect" {
  description = "This parameter indicates whether or not the action is allowed. Valid values are Allow and Deny"
  type        = string
  default     = "Allow"
}

variable "force" {
  description = "This parameter is used for resource destroy. Default value is false"
  type        = string
  default     = false
}

variable "oss_bucket_actions" {
  description = "oss bucket custom actions used to create a ram policy"
  type        = string
  default     = "oss:PutBucket*,SetBucket,GetBucket*,DeleteBucket*"
}

variable "oss_bucket_resources" {
  description = "the resources used to create a ram policy of oss bucket, default to [*]"
  type        = string
  default     = "acs:oss:*:*:*"
}

variable "slb_eip_defined_actions" {
  description = "slb eip defined actions used to create a ram policy"
  type        = string
  default     = "slb-all,vpc-all,vswitch-all"
}

variable "slb_eip_actions" {
  description = "slb eip custom actions used to create a ram policy"
  type        = string
  default     = "vpc:AssociateEipAddress, vpc:UnassociateEipAddress"
}

variable "slb_eip_resources" {
  description = "the resources used to create a ram policy of slb eip, default to [*]"
  type        = string
  default     = "acs:vpc:*:*:eip/eip-12345,acs:slb:*:*:*"
}