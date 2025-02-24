locals {
  policy_json = <<EOF
{
  "Version": "1",
  "Statement": [
    {
      "Action": "ahas:*",
      "Resource": "*",
      "Effect": "Allow",
      "Condition": {
        "StringNotLike": {
          "Action": [
            "ahas:CheckAppAuth",
            "ahas:*Delete*",
            "ahas:*Add*",
            "ahas:*Edit*",
            "ahas:*Update*",
            "ahas:Sentinel*New",
            "ahas:Sentinel*Edit",
            "ahas:Sentinel*On",
            "ahas:Sentinel*Off",
            "ahas:Sentinel*Batch",
            "ahas:*Create*"
          ]
        }
      }
    },
    {
      "Effect": "Allow",
      "Action": "ahas:CheckAppAuth",
      "Resource": ${jsonencode([for application in var.ahas_applications: "acs:ahas:*:*:namespace/${var.ahas_namespace}/${application}"])}
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
