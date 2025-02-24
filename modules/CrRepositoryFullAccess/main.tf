locals {
  policy_json = <<EOF
{
  "Statement": [
    {
      "Action": "cr:*",
      "Effect": "Allow",
      "Resource": ${jsonencode([for repository in var.cr_repositories: "acs:cr:*:*:repository/${var.cr_namespace}/${repository}"])}
    },
    {
      "Action": [
        "cr:Get*",
        "cr:List*"
      ],
      "Effect": "Allow",
      "Resource": "acs:cr:*:*:repository/${var.cr_namespace}/*"
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
