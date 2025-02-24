locals {
  policy_json = <<EOF
{
  "Version": "1",
  "Statement": [
    {
      "Action": "ahas:*",
      "Resource": "*",
      "Effect": "Allow",
      "Condition": {
        "StringNotLike": {
          "Action": "ahas:CheckAppAuth"
        }
      }
    },
    {
      "Effect": "Allow",
      "Action": "ahas:CheckAppAuth",
      "Resource": ${jsonencode([for application in var.ahas_applications: "acs:ahas:*:*:namespace/${var.ahas_namespace}/${application}"])}
    },
    {
      "Action": "ram:CreateServiceLinkedRole",
      "Resource": "*",
      "Effect": "Allow",
      "Condition": {
        "StringEquals": {
          "ram:ServiceName": "ahas.aliyuncs.com"
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
