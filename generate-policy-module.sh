#!/bin/sh

if [[ $# != 4 ]]; then
    echo "Usage: $0 MODULE_NAME POLICY_NAME POLICY_DESCRIPTION POLICY_DOCUMENT"
    exit 1
fi

module_name=$1
policy_name=$2
policy_description=$3
policy_document=$4

# 创建module目录和example目录
if [[ ! -e modules/$module_name ]]; then
    mkdir modules/$module_name
fi
if [[ ! -e examples/$module_name ]]; then
    mkdir examples/$module_name
fi

cat > modules/$module_name/main.tf <<EOF1
locals {
  policy_json = <<EOF
${policy_document}
EOF
}

resource "alicloud_ram_policy" "policy" {
  count = var.create ? 1 : 0
  policy_name = "\${var.policy_name}\${var.policy_name_suffix}"
  description = var.description
  policy_document = local.policy_json
}
EOF1

cat > examples/$module_name/main.tf <<EOF
terraform {
  required_version = ">= 1.0"

  required_providers {
    alicloud = {
      source = "aliyun/alicloud"
      version = ">= 1.220.0"
    }
  }
}

module "example" {
  source = "../../modules/${module_name}"
}
EOF

cat > modules/$module_name/variables.tf <<EOF
variable "create" {
  description = "Whether to create the RAM policy"
  type        = bool
  default     = true
}

variable "policy_name" {
  description = "The name of the policy"
  type        = string
  default     = "${policy_name}"
}

variable "policy_name_suffix" {
  description = "The suffix to append to the default name of the policy"
  type        = string
  default     = ""
}

variable "description" {
  description = "The description of the policy"
  type        = string
  default     = "${policy_description}"
}
EOF

cat > modules/$module_name/outputs.tf <<EOF
output "policy_json" {
  description = "Policy document as json. Useful if you need document but do not want to create IAM policy itself. For example for CloudSSO Permission Set inline policies"
  value       = local.policy_json
}

output "id" {
  description = "The policy's ID"
  value       = try(alicloud_ram_policy.policy[0].id, "")
}

output "description" {
  description = "The description of the policy"
  value       = try(alicloud_ram_policy.policy[0].description, "")
}

output "policy_name" {
  description = "The name of the policy"
  value       = try(alicloud_ram_policy.policy[0].policy_name, "")
}

output "policy_document" {
  description = "The policy document"
  value       = try(alicloud_ram_policy.policy[0].policy_document, "")
}
EOF

cat > examples/$module_name/outputs.tf <<EOF
output "policy_json" {
  description = "Policy document as json. Useful if you need document but do not want to create IAM policy itself. For example for CloudSSO Permission Set inline policies"
  value       = module.example.policy_json
}

output "id" {
  description = "The policy's ID"
  value       = module.example.id
}

output "description" {
  description = "The description of the policy"
  value       = module.example.description
}

output "policy_name" {
  description = "The name of the policy"
  value       = module.example.policy_name
}

output "policy_document" {
  description = "The policy document"
  value       = module.example.policy_document
}
EOF

cat > modules/$module_name/README.md <<EOF
<!-- 在根目录下运行命令 `terraform-docs markdown . --output-file "./README.md"`，可将所有信息自动填充 -->
<!-- BEGIN_TF_DOCS -->
<!-- END_TF_DOCS -->
EOF

cat > examples/$module_name/README.md <<EOF
<!-- 在根目录下运行命令 `terraform-docs markdown . --output-file "./README.md"`，可将所有信息自动填充 -->
<!-- BEGIN_TF_DOCS -->
<!-- END_TF_DOCS -->
EOF

cat > modules/$module_name/version.tf <<EOF
terraform {
  required_version = ">= 1.0"

  required_providers {
    alicloud = {
      source = "aliyun/alicloud"
      version = ">= 1.220.0"
    }
  }
}
EOF
