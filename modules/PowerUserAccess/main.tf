locals {
  policy_json = <<EOF
{
  "Version": "1",
  "Statement": [
    {
      "NotAction": [
        "ram:*",
        "ims:*",
        "resourcemanager:*",
        "resourcesharing:*",
        "bss:ModifyAccount",
        "bss:ModifyBillingAccount",
        "bss:ModifyPaymentRelationship",
        "bssapi:ModifyAccountRelation"
      ],
      "Resource": "*",
      "Effect": "Allow"
    },
    {
      "Action": [
        "ram:ListRoles",
        "ram:GetRole",
        "ram:PassRole",
        "ram:CreateServiceLinkedRole",
        "ram:DeleteServiceLinkedRole",
        "ram:GetServiceLinkedRoleDeletionStatus",
        "ram:CheckServiceLinkedRoleExistence",
        "ram:*ResourceGroup*",
        "resourcemanager:ListAccounts",
        "resourcemanager:GetAccount",
        "resourcemanager:GetResourceDirectory",
        "resourcemanager:GetFolder",
        "resourcemanager:ListFoldersForParent",
        "resourcemanager:ListAccountsForParent"
      ],
      "Resource": "*",
      "Effect": "Allow"
    },
    {
      "Effect": "Allow",
      "Action": [
        "ram:CreateRole",
        "ram:AttachPolicyToRole"
      ],
      "Resource": "acs:ram:*:*:role/*",
      "Condition": {
        "ForAllValues:StringEquals": {
          "ram:TrustedPrincipalTypes": "Service"
        }
      }
    },
    {
      "Effect": "Allow",
      "Action": "ram:AttachPolicyToRole",
      "Resource": "acs:ram:*:*:policy/*"
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
