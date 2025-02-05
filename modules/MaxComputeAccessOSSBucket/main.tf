locals {
  policy_json = <<EOF
{
  "Version": "1",
  "Statement": [
    {
      "Action": [
        "oss:ListBuckets",
        "oss:ListObjects",
        "oss:GetObject",
        "oss:DeleteObject",
        "oss:PutObject",
        "oss:ListParts",
        "oss:AbortMultipartUpload"
      ],
      "Resource": "acs:oss:*:*:${var.oss_bucket_name}/*",
      "Effect": "Allow"
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
