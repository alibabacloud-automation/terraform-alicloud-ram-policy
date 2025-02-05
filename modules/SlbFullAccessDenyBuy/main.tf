locals {
  policy_json = <<EOF
{
  "Version": "1",
  "Statement": [
    {
      "Effect": "Deny",
      "Action": [
        "slb:CreateLoadBalancer",
        "slb:ModifyLoadBalancerInternetSpec",
        "slb:ModifyLoadBalancerInstanceSpec",
        "slb:ModifyLoadBalancerPayType"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "slb:*"
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
