locals {
  policy_json = <<EOF
{
  "Version": "1",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "oss:*",
      "Resource": ${jsonencode(concat(["acs:oss:*:*:${var.oss_bucket_name}"], [for object_name in var.oss_object_names: "acs:oss:*:*:${var.oss_bucket_name}/${object_name}"]))}
    },
    {
      "Effect": "Deny",
      "Action": "oss:DeleteBucket",
      "Resource": "acs:oss:*:*:${var.oss_bucket_name}"
    },
    {
      "Effect": "Deny",
      "Action": "oss:DeleteObject",
      "Resource": ${jsonencode([for object_name in var.oss_object_names: "acs:oss:*:*:${var.oss_bucket_name}/${object_name}"])}
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
