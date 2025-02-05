locals {
  policy_json = <<EOF
{
  "Version": "1",
  "Statement": [
    {
      "Action": [
        "actiontrail:*",
        "log:*",
        "config:*",
        "resourcecenter:*"
      ],
      "Resource": "*",
      "Effect": "Allow"
    },
    {
      "Action": [
        "*:Describe*",
        "*:List*",
        "*:Get*",
        "*:BatchGet*",
        "*:Query*",
        "*:BatchQuery*",
        "dm:Desc*",
        "dm:SenderStatistics*"
      ],
      "Resource": "*",
      "Effect": "Allow"
    },
    {
      "Action": [
        "bss:*",
        "efc:*"
      ],
      "Effect": "Deny",
      "Resource": "*"
    },
    {
      "Action": "ram:CreateServiceLinkedRole",
      "Resource": "*",
      "Effect": "Allow",
      "Condition": {
        "StringEquals": {
          "ram:ServiceName": [
            "audit.log.aliyuncs.com",
            "alert.log.aliyuncs.com",
            "middlewarelens.log.aliyuncs.com",
            "storagelens.log.aliyuncs.com",
            "ai-lens.log.aliyuncs.com",
            "securitylens.log.aliyuncs.com",
            "config.aliyuncs.com",
            "actiontrail.aliyuncs.com"
          ]
        }
      }
    },
    {
      "Action": "ram:PassRole",
      "Resource": "*",
      "Effect": "Allow",
      "Condition": {
        "StringEquals": {
          "acs:Service": "actiontrail.aliyuncs.com"
        }
      }
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
