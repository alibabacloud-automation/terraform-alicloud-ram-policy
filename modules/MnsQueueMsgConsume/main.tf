locals {
  policy_json = <<EOF
{
  "Version": "1",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "mns:SendMessage",
        "mns:ReceiveMessage",
        "mns:DeleteMessage",
        "mns:PeekMessage",
        "mns:ChangeMessageVisibility",
        "mns:PublishMessage"
      ],
      "Resource": ${jsonencode([for queue in var.mns_queues: "acs:mns:*:*:/queues/${queue}"])}
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
