locals {
  policy_json = <<EOF
{
  "Version": "1",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "log:Post*",
        "log:BatchPost*"
      ],
      "Resource": ${jsonencode([for logstore in var.sls_logstores: "acs:log:*:*:${var.sls_project}/${logstore}"])}
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
