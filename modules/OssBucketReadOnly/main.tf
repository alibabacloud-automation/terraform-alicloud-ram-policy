locals {
  policy_json = <<EOF
{
  "Version": "1",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "oss:ListBuckets",
        "oss:GetBucketStat",
        "oss:GetBucketInfo",
        "oss:GetBucketTagging",
        "oss:GetBucketLifecycle",
        "oss:GetBucketWorm",
        "oss:GetBucketVersioning",
        "oss:GetBucketAcl"
      ],
      "Resource": "acs:oss:*:*:*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "oss:ListObjects",
        "oss:GetBucketAcl"
      ],
      "Resource": "acs:oss:*:*:${var.oss_bucket_name}"
    },
    {
      "Effect": "Allow",
      "Action": [
        "oss:GetObject",
        "oss:GetObjectAcl"
      ],
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
