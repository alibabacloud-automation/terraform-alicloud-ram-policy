locals {
  policy_json = <<EOF
{
  "Version": "1",
  "Statement": [
    {
      "Action": [
        "bss:Describe*",
        "bss:Export*",
        "bss:QueryDownloadFileList",
        "bssapi:Describe*",
        "bssapi:Get*",
        "bssapi:Query*",
        "efc:Get*",
        "efc:Query*",
        "efc:Check*",
        "efc:Verify*",
        "efc:Validate*",
        "efc:CurrentProductFee",
        "efc:BillAnalysis"
      ],
      "Resource": "*",
      "Effect": "Allow"
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
