locals {
  policy_json = <<EOF
{
  "Version": "1",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "alidns:*",
      "Resource": ${jsonencode([for domain in var.alidns_domains: "acs:alidns:*:*:domain/${domain}"])}
    },
    {
      "Effect": "Allow",
      "Action": [
        "alidns:DescribeDomains",
        "alidns:DescribeDomainNs",
        "alidns:DescribeDomainGroups",
        "alidns:DescribeSiteMonitorIspInfos",
        "alidns:DescribeSiteMonitorIspCityInfos"
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
