locals {
  policy_json = <<EOF
{
  "Version": "1",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "kvstore:DescribeInstances",
        "kvstore:DescribeSecurityIps",
        "kvstore:DescribeSecurityGroupConfiguration",
        "kvstore:DescribeInstanceAttribute",
        "kvstore:DescribeAccounts",
        "kvstore:CreateAccount",
        "kvstore:ResetAccountPassword",
        "kvstore:ModifySecurityIps"
      ],
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
