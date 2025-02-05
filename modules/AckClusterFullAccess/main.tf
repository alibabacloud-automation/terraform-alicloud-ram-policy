locals {
  policy_json = <<EOF
{
  "Version": "1",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "cs:Get*",
        "cs:List*",
        "cs:Describe*"
      ],
      "Resource": ${jsonencode([for cluster in var.ack_clusters: "acs:cs:*:*:cluster/${cluster}"])}
    },
    {
      "Action": "cs:DescribeKubernetesVersionMetadata",
      "Effect": "Allow",
      "Resource": "*"
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
