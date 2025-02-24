locals {
  policy_json = <<EOF
{
  "Version": "1",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ots:GetRow",
        "ots:BatchGetRow",
        "ots:GetRange",
        "ots:Search"
      ],
      "Resource": ${jsonencode(concat(["acs:ots:*:*:instance/${var.ots_instance}"], [for table in var.ots_tables: "acs:ots:*:*:instance/${var.ots_instance}/${table}"]))}
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
