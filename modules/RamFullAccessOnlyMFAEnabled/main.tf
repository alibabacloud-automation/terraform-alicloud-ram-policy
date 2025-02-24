locals {
  policy_json = <<EOF
{
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "ram:*",
      "Resource": "*"
    },
    {
      "Effect": "Deny",
      "Action": "ram:*",
      "Resource": "*",
      "Condition": {
        "Bool": {
          "acs:MFAPresent": [
            "false"
          ]
        }
      }
    }
  ],
  "Version": "1"
}
EOF
}

resource "alicloud_ram_policy" "policy" {
  count = var.create ? 1 : 0
  policy_name = "${var.policy_name}${var.policy_name_suffix}"
  description = var.description
  policy_document = local.policy_json
}
