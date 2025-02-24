locals {
  policy_json = <<EOF
{
  "Statement": [
    {
      "Action": [
        "cr:Get*",
        "cr:List*",
        "cr:PullRepository"
      ],
      "Effect": "Allow",
      "Resource": "acs:cr:*:*:repository/${var.cr_namespace}/*"
    },
    {
      "Action": [
        "cr:ListNamespace",
        "cr:ListRepository"
      ],
      "Effect": "Allow",
      "Resource": "*"
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
