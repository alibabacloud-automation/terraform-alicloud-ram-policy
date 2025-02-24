locals {
  policy_json = <<EOF
{
  "Version": "1",
  "Statement": [
    {
      "Effect": "Deny",
      "Action": [
        "ecs:RunInstances",
        "ecs:CreateInstance",
        "ecs:ModifyInstanceAutoRenewAttribute",
        "ecs:ModifyInstanceChargeType",
        "ecs:ModifyInstanceSpec",
        "ecs:ModifyPrepayInstanceSpec",
        "ecs:RenewInstance",
        "ecs:AllocateDedicatedHosts",
        "ecs:RenewDedicatedHosts",
        "ecs:ModifyDedicatedHostsChargeType",
        "ecs:CreateDisk",
        "ecs:ModifyDiskSpec",
        "ecs:ModifyDiskChargeType",
        "ecs:CreateSnapshot"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "ecs:*"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}

resource "alicloud_ram_policy" "policy" {
  count = var.create ? 1 : 0
  policy_name = "${var.policy_name}${var.policy_name_suffix}"
  description = var.description
  policy_document = local.policy_json
}
