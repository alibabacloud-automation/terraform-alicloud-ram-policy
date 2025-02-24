locals {
  policy_json = <<EOF
{
  "Version": "1",
  "Statement": [
    {
      "Action": [
        "yundun-*:*",
        "sasti:Get*",
        "sasti:Describe*",
        "sasti:Query*",
        "sasti:List*",
        "sasti:Grant*",
        "bss:QueryAvailableInstances",
        "bssapi:QuerySavingsPlansInstance",
        "pam:*",
        "kms:*",
        "mssp:*",
        "ddosdiversion:*",
        "actiontrail:*",
        "hbr:Describe*",
        "hbr:Get*",
        "hbr:Search*",
        "hbr:BrowseFiles",
        "hbr:List*",
        "hbr:BatchCountTables",
        "hbr:QueryAvailableInstances",
        "hbr:CheckRole",
        "hbr:PreCheckSourceGroup",
        "ram:Get*",
        "ram:List*",
        "ram:GenerateCredentialReport",
        "quotas:List*",
        "quotas:Get*",
        "cloudsso:List*",
        "cloudsso:Get*",
        "cloudsso:Check*",
        "advisor:*",
        "config:*",
        "cms:Get*",
        "cms:List*",
        "cms:Query*",
        "cms:BatchQuery*",
        "cms:Describe*",
        "cms:Check*",
        "cms:Cursor",
        "cms:BatchGet",
        "cms:BatchExport"
      ],
      "Resource": "*",
      "Effect": "Allow"
    },
    {
      "Action": "ram:CreateServiceLinkedRole",
      "Resource": "*",
      "Effect": "Allow",
      "Condition": {
        "StringEquals": {
          "ram:ServiceName": [
            "secretsmanager-rds.kms.aliyuncs.com",
            "bastionhost.aliyuncs.com",
            "sddp.aliyuncs.com",
            "keystore.kms.aliyuncs.com",
            "actiontrail.aliyuncs.com",
            "config.aliyuncs.com"
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
