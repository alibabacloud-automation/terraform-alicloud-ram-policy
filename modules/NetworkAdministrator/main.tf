locals {
  policy_json = <<EOF
{
  "Version": "1",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "vpc:*",
        "cen:*",
        "slb:*",
        "alb:*",
        "smartag:*",
        "ga:*",
        "alidns:*",
        "cdn:*",
        "yundun-ddoscoo:*",
        "yundun-ddosdip:*",
        "ecs:DescribeInstances",
        "ecs:*SecurityGroup*",
        "ecs:CreateNetworkInterface",
        "ecs:DeleteNetworkInterface",
        "ecs:DescribeNetworkInterfaces",
        "ecs:CreateNetworkInterfacePermission",
        "ecs:DescribeNetworkInterfacePermissions",
        "ecs:DeleteNetworkInterfacePermission",
        "eci:DescribeContainerGroups",
        "cms:QueryMetric*"
      ],
      "Resource": [
        "*"
      ],
      "Condition": {}
    },
    {
      "Effect": "Allow",
      "Action": [
        "ram:PassRole"
      ],
      "Resource": [
        "*"
      ],
      "Condition": {
        "StringEquals": {
          "acs:Service": [
            "slb.aliyuncs.com"
          ]
        }
      }
    },
    {
      "Effect": "Allow",
      "Action": [
        "ram:CreateServiceLinkedRole"
      ],
      "Resource": [
        "*"
      ],
      "Condition": {
        "StringEquals": {
          "ram:ServiceName": [
            "nat.aliyuncs.com",
            "cen.aliyuncs.com",
            "logdelivery.slb.aliyuncs.com",
            "alb.aliyuncs.com",
            "logdelivery.alb.aliyuncs.com",
            "vpcendpoint.ga.aliyuncs.com",
            "alidns.aliyuncs.com",
            "gtm.aliyuncs.com",
            "cdn-waf.cdn.aliyuncs.com",
            "cdn-ddos.cdn.aliyuncs.com",
            "logdelivery.cdn.aliyuncs.com"
          ]
        }
      }
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
