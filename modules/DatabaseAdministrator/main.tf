locals {
  policy_json = <<EOF
{
  "Version": "1",
  "Statement": [
    {
      "Action": [
        "rds:*",
        "drds:*",
        "polardbx:*",
        "hdm:*",
        "kvstore:*",
        "polardb:*",
        "adb:*",
        "dts:*",
        "dds:*",
        "petadata:*",
        "gpdb:*",
        "hbase:*",
        "yundun-dbaudit:*",
        "hitsdb:*",
        "dbs:*",
        "gdb:*",
        "adam:*",
        "dbes:*",
        "dg:*",
        "oceanbase:*",
        "cassandra:*",
        "clickhouse:*",
        "openanalytics:*",
        "lindorm:*",
        "vpc:DescribeVpcs",
        "vpc:DescribeVSwitches",
        "ecs:DescribeSecurityGroups"
      ],
      "Resource": "*",
      "Effect": "Allow"
    },
    {
      "Action": [
        "dms:LoginDatabase"
      ],
      "Resource": [
        "acs:rds:*:*:*",
        "acs:polardb:*:*:*",
        "acs:dds:*:*:*",
        "acs:openanalytics:*:*:*"
      ],
      "Effect": "Allow"
    },
    {
      "Action": [
        "alikafka:ListInstance",
        "alikafka:ListTopic",
        "alikafka:QueryMessage"
      ],
      "Resource": "acs:alikafka:*:*:*",
      "Effect": "Allow"
    },
    {
      "Action": "ram:PassRole",
      "Resource": "*",
      "Effect": "Allow",
      "Condition": {
        "StringEquals": {
          "acs:Service": [
            "drds.aliyuncs.com",
            "dts.aliyuncs.com",
            "hdm.aliyuncs.com",
            "openanalytics.aliyuncs.com"
          ]
        }
      }
    },
    {
      "Action": "ram:CreateServiceLinkedRole",
      "Resource": "*",
      "Effect": "Allow",
      "Condition": {
        "StringEquals": {
          "ram:ServiceName": [
            "backupencryption.rds.aliyuncs.com",
            "r-kvstore.aliyuncs.com",
            "polardb.aliyuncs.com",
            "ads.aliyuncs.com",
            "mongodb.aliyuncs.com",
            "adbpg.aliyuncs.com",
            "dbaudit.aliyuncs.com",
            "hitsdb.aliyuncs.com",
            "dbs.aliyuncs.com",
            "gdb.aliyuncs.com",
            "clickhouse.aliyuncs.com",
            "openanalytics.aliyuncs.com"
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
