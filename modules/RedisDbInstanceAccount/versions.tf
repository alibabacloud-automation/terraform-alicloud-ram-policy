########################
# 当前 Module 的版本约束。alicloud 的 source 必须为 "hashicorp/alicloud"
########################
terraform {
  required_version = ">= 0.13"
  required_providers {
    alicloud = {
      source = "hashicorp/alicloud"
    }
  }
}
