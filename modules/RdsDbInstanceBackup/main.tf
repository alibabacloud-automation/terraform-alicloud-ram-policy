locals {
  policy_json = <<EOF
{
  "Version": "1",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "rds:CreateBackup",
        "rds:ModifyBackupPolicy"
      ],
      "Resource": ${jsonencode([for db in var.rds_dbinstances: "acs:rds:*:*:dbinstances/${db}"])}
    },
    {
      "Effect": "Allow",
      "Action": "rds:Describe*",
      "Resource": "acs:rds:*:*:*"
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
