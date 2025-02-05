terraform-alicloud-ram-policy
=====================================================================

中文简体 | [English](./README.md)

terraform-alicloud-ram-policy 用于场景化的的策略创建。

## 用法

场景化的策略模版全部位于子模块中，请查看 examples 目录中的示例获取适合
你需要的子模块。 不推荐使用主模块，使用
[alicloud_ram_policy_document](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/ram_policy_document)
代替主模块，主模块的保留主要是为了避免给存量用户带来兼容性影响。

### 基础用法

创建一个财务人员只读的策略（无参数）

```hcl
module "example" {
  source = "terraform-alicloud-modules/ram-policy/alicloud//modules/BssReadOnly"
  create_policy = true
}
```

创建一个对部分OSS Object前缀只读的策略（带参数）

```hcl
module "example" {
  source = "terraform-alicloud-modules/ram-policy/alicloud//modules/OssBucketReadOnly"
  create_policy = true
  oss_bucket_name = "bkt1"
  oss_object_names = ["foo/*", "bar/*"]
}
```

策略模板的输出中，最关键的两个信息：

* policy\_name - 策略的名称
* policy\_document - 策略文档的JSON字符串（依赖创建策略实体）
* policy\_json - 策略文档的JSON字符串（在不创建策略实体的情况下，可用该字段获取策略内容）


### 指定策略名称

默认情况下，策略模版有默认的策略名称，与策略模板同名。如果你需要在账号下用同一个模板创建多个策略，那么你需要指定不同的策略名称。

你可以指定完整的策略名称，如：

```hcl
module "example" {
  source = "terraform-alicloud-modules/ram-policy/alicloud//modules/OssBucketReadOnly"
  create_policy = true
  policy_name = "MyCustomPolicyName"
  oss_bucket_name = "bkt1"
  oss_object_names = ["foo/*", "bar/*"]
}
```

也可以在默认名称之后添加后缀，如：

```hcl
module "example" {
  source = "terraform-alicloud-modules/ram-policy/alicloud//modules/OssBucketReadOnly"
  create_policy = true
  policy_name_suffix = "-ForBucket1"
  oss_bucket_name = "bkt1"
  oss_object_names = ["foo/*", "bar/*"]
}
```

### 组合多个场景

策略模版支持仅输出策略文档内容（create\_policy设置为false），而不创建策略实体，同时利用 [alicloud_ram_policy_document](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/ram_policy_document) 可以将多个策略文档内容合并成一个，从而创建更丰富的策略。

```hcl
module "policy1" {
  source = "terraform-alicloud-modules/ram-policy/alicloud//modules/BssReadOnly"
}

module "policy2" {
  source = "terraform-alicloud-modules/ram-policy/alicloud//modules/OssBucketReadOnly"
  oss_bucket_name = "bkt1"
  oss_object_names = ["foo/*", "bar/*"]
}

data "alicloud_ram_policy_document" {
  source_policy_documents = [module.policy1.policy_json, module.policy2.policy_json]
}
```


## 模块

* [PowerUserAccess](./modules/PowerUserAccess)([example](./examples/PowerUserAccess)) - 负责企业的云上运维管理，可创建、查看、操作所有的云服务，不能管理身份权限、不能管理账号架构、不能使用财务关联。
* [FinanceStaff](./modules/FinanceStaff)([example](./examples/FinanceStaff)) - 负责企业的财务工作，可查看账单、充值付款、开取发票等，可使用财务分析功能，拥有财账系统的全部权限。
* [NetworkAdministrator](./modules/NetworkAdministrator)([example](./examples/NetworkAdministrator)) - 负责企业的网络架构搭建和管理，可开通和购买创建网络服务，拥有网络服务的所有权限和 ECS 安全组的权限。
* [DatabaseAdministrator](./modules/DatabaseAdministrator)([example](./examples/DatabaseAdministrator)) - 负责企业的数据库运维管理，可开通和购买创建数据库服务，拥有数据库服务的所有权限。
* [SecurityAdministrator](./modules/SecurityAdministrator)([example](./examples/SecurityAdministrator)) - 负责企业云上安全，可开通和购买云安全服务，制定并实施安全规则，拥有安全服务的所有权限。
* [AuditAdministrator](./modules/AuditAdministrator)([example](./examples/AuditAdministrator)) - 具有配置审计、操作审计和日志管理的全部权限，同时可以查询所有阿里云资源现状。
* [EcsFullAccessDenySecurityChange](./modules/EcsFullAccessDenySecurityChange)([example](./examples/EcsFullAccessDenySecurityChange)) - 允许完全访问 ECS，禁止变更安全组的操作。
* [RdsFullAccessDenySecurityChange](./modules/RdsFullAccessDenySecurityChange)([example](./examples/RdsFullAccessDenySecurityChange)) - 允许完全访问 RDS，禁止变更数据库安全白名单 IP 的操作。
* [EcsInstanceReboot](./modules/EcsInstanceReboot)([example](./examples/EcsInstanceReboot)) - 允许列出所有 ECS 实例、重启指定 ECS 实例。
* [EcsInstanceRunCommand](./modules/EcsInstanceRunCommand)([example](./examples/EcsInstanceRunCommand)) - 允许列出所有 ECS 实例、运行和停止远程命令。
* [RdsDbInstanceBackup](./modules/RdsDbInstanceBackup)([example](./examples/RdsDbInstanceBackup)) - 允许列出所有 RDS 实例和备份指定 RDS 实例。
* [RedisDbInstanceAccount](./modules/RedisDbInstanceAccount)([example](./examples/RedisDbInstanceAccount)) - 允许为所有 Redis 实例创建账号、修改密码、设置 IP 白名单。
* [OssBucketReadOnly](./modules/OssBucketReadOnly)([example](./examples/OssBucketReadOnly)) - 允许通过 OSS 控制台读取指定 Bucket 的所有资源。
* [MnsQueueMsgConsume](./modules/MnsQueueMsgConsume)([example](./examples/MnsQueueMsgConsume)) - 允许向指定 MNS 队列写入和消费消息、设置消息可见性、消费成功后删除消息。
* [OssBucketPutObject](./modules/OssBucketPutObject)([example](./examples/OssBucketPutObject)) - 允许向指定的 OSS Bucket 写入并读取对象，无删除权限，适用于文件上传下载场景。
* [OtsInstanceGetRow](./modules/OtsInstanceGetRow)([example](./examples/OtsInstanceGetRow)) - 允许查询指定 OTS 实例中的所有表格数据，可获取单行数据，批量查询多行数据，使用多元索引进行搜索。
* [OssBucketFullAccessDenyDelete](./modules/OssBucketFullAccessDenyDelete)([example](./examples/OssBucketFullAccessDenyDelete)) - 允许访问指定 Bucket 所有资源，禁止删除指定资源。
* [CrRepositoryPull](./modules/CrRepositoryPull)([example](./examples/CrRepositoryPull)) - 允许列出全部命名空间并拉取指定命名空间的所有仓库。
* [CrRepositoryFullAccess](./modules/CrRepositoryFullAccess)([example](./examples/CrRepositoryFullAccess)) - 允许完全访问容器镜像服务的指定仓库。
* [KmsKeyUse](./modules/KmsKeyUse)([example](./examples/KmsKeyUse)) - 允许列出、查看和使用密钥。
* [KmsSecretReadOnly](./modules/KmsSecretReadOnly)([example](./examples/KmsSecretReadOnly)) - 允许列出和查看凭据。
* [AlidnsDomainFullAccess](./modules/AlidnsDomainFullAccess)([example](./examples/AlidnsDomainFullAccess)) - 允许列出所有域名并管理指定域名。
* [EcsFullAccessDenyBuy](./modules/EcsFullAccessDenyBuy)([example](./examples/EcsFullAccessDenyBuy)) - 允许完全访问 ECS，禁止购买、续费、变配等资金相关操作。
* [RdsFullAccessDenyBuy](./modules/RdsFullAccessDenyBuy)([example](./examples/RdsFullAccessDenyBuy)) - 允许完全访问 RDS，禁止购买、续费等资金相关操作。
* [RedisFullAccessDenyBuy](./modules/RedisFullAccessDenyBuy)([example](./examples/RedisFullAccessDenyBuy)) - 允许完全访问 Redis，禁止购买、续费、变配等资金相关操作。
* [SlbFullAccessDenyBuy](./modules/SlbFullAccessDenyBuy)([example](./examples/SlbFullAccessDenyBuy)) - 允许完全访问 SLB，禁止购买、续费、变配等资金相关操作。
* [BssReadOnly](./modules/BssReadOnly)([example](./examples/BssReadOnly)) - 允许查看费用中心，支持导出订单和账单数据。
* [RamFullAccessOnlyMFAEnabled](./modules/RamFullAccessOnlyMFAEnabled)([example](./examples/RamFullAccessOnlyMFAEnabled)) - 允许用户完全访问 RAM，禁止 MFA 未启用的用户访问 RAM .
* [PostLogToSlsProject](./modules/PostLogToSlsProject)([example](./examples/PostLogToSlsProject)) - 允许向指定日志项目投递日志
* [AckClusterFullAccess](./modules/AckClusterFullAccess)([example](./examples/AckClusterFullAccess)) - 允许列出和查询指定的容器服务集群。
* [AhasApplicaitonReadOnly](./modules/AhasApplicaitonReadOnly)([example](./examples/AhasApplicaitonReadOnly)) - 允许查看指定 AHAS 应用
* [AhasApplicaitonFullAccess](./modules/AhasApplicaitonFullAccess)([example](./examples/AhasApplicaitonFullAccess)) - 允许查看指定 AHAS 应用和授权服务启用
* [MaxComputeAccessOSSBucket](./modules/MaxComputeAccessOSSBucket)([example](./examples/MaxComputeAccessOSSBucket)) - 允许 MaxCompute 访问指定 OSS Bucket
* [MaxComputeAccessKMSKey](./modules/MaxComputeAccessKMSKey)([example](./examples/MaxComputeAccessKMSKey)) - 允许按照 MaxCompute 需要使用 KMS 密钥执行加解密

## 示例

## 注意事项
本Module从版本v1.1.0开始已经移除掉如下的 provider 的显示设置：

```hcl
provider "alicloud" {
  version                 = ">=1.64.0"
  profile                 = var.profile != "" ? var.profile : null
  shared_credentials_file = var.shared_credentials_file != "" ? var.shared_credentials_file : null
  region                  = var.region != "" ? var.region : null
  skip_region_validation  = var.skip_region_validation
  configuration_source    = "terraform-alicloud-modules/ram-policy"
}
```

如果你依然想在Module中使用这个 provider 配置，你可以在调用Module的时候，指定一个特定的版本，比如 1.0.0:

```hcl
module "ram-policy" {
  source   = "terraform-alicloud-modules/ram-policy/alicloud"
  version  = "1.0.0"
  region   = "cn-shenzhen"
  profile  = "Your-Profile-Name"
  policies = [
    {
      name            = "test"
      defined_actions = join(",", ["instance-create", "vpc-create", "vswitch-create", "security-group-create"])
      effect          = "Allow"
      force           = "true"
    }
  ]
  // ...
}
```

如果你想对正在使用中的Module升级到 1.1.0 或者更高的版本，那么你可以在模板中显示定义一个系统过Region的provider：
```hcl
provider "alicloud" {
  region  = "cn-shenzhen"
  profile = "Your-Profile-Name"
}
module "ram-policy" {
  source   = "terraform-alicloud-modules/ram-policy/alicloud"
  policies = [
    {
      name            = "test"
      defined_actions = join(",", ["instance-create", "vpc-create", "vswitch-create", "security-group-create"])
      effect          = "Allow"
      force           = "true"
    }
  ]
  // ...
}
```
或者，如果你是多Region部署，你可以利用 `alias` 定义多个 provider，并在Module中显示指定这个provider：

```hcl
provider "alicloud" {
  region  = "cn-shenzhen"
  profile = "Your-Profile-Name"
  alias   = "sz"
}
module "ram-policy" {
  source   = "terraform-alicloud-modules/ram-policy/alicloud"
  providers         = {
    alicloud = alicloud.sz
  }
  policies = [
    {
      name            = "test"
      defined_actions = join(",", ["instance-create", "vpc-create", "vswitch-create", "security-group-create"])
      effect          = "Allow"
      force           = "true"
    }
  ]
  // ...
}
```

定义完provider之后，运行命令 `terraform init` 和 `terraform apply` 来让这个provider生效即可。

更多provider的使用细节，请移步[How to use provider in the module](https://www.terraform.io/docs/language/modules/develop/providers.html#passing-providers-explicitly)

<!-- 在根目录下运行命令 `terraform-docs markdown . --output-file "./README.md"`，可将所有信息自动填充 -->
<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [alicloud_ram_policy.policy_with_actions](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/ram_policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create"></a> [create](#input\_create) | (Deprecated) Whether to create RAM policies. If true, the policies should not be empty. | `bool` | `true` | no |
| <a name="input_defined_actions"></a> [defined\_actions](#input\_defined\_actions) | (Deprecated) Map of several defined actions | `map(list(string))` | <pre>{<br/>  "db-instance-all": [<br/>    "rds:*Instance*",<br/>    "rds:ModifyParameter",<br/>    "rds:UntagResources",<br/>    "rds:TagResources",<br/>    "rds:ModifySecurityGroupConfiguration",<br/>    "rds:DescribeTags",<br/>    "rds:DescribeSQLCollector*",<br/>    "rds:DescribeParameters",<br/>    "rds:DescribeSecurityGroupConfiguration"<br/>  ],<br/>  "db-instance-create": [<br/>    "rds:CreateDBInstance",<br/>    "vpc:DescribeVSwitchAttributes",<br/>    "rds:ModifyParameter",<br/>    "rds:UntagResources",<br/>    "rds:TagResources",<br/>    "rds:ModifyInstanceAutoRenewalAttribute",<br/>    "rds:ModifySecurityGroupConfiguration",<br/>    "rds:ModifyDBInstance*",<br/>    "rds:DescribeDBInstance*",<br/>    "rds:DescribeTags",<br/>    "rds:DescribeSQLCollector*",<br/>    "rds:DescribeParameters",<br/>    "rds:DescribeInstanceAutoRenewalAttribute",<br/>    "rds:DescribeSecurityGroupConfiguration"<br/>  ],<br/>  "db-instance-delete": [<br/>    "rds:DeleteDBInstance",<br/>    "rds:DescribeDBInstanceAttribute"<br/>  ],<br/>  "db-instance-read": [<br/>    "rds:DescribeDBInstance*",<br/>    "rds:DescribeTags",<br/>    "rds:DescribeSQLCollector*",<br/>    "rds:DescribeParameters",<br/>    "rds:DescribeInstanceAutoRenewalAttribute",<br/>    "rds:DescribeSecurityGroupConfiguration"<br/>  ],<br/>  "db-instance-update": [<br/>    "rds:ModifyParameter",<br/>    "rds:UntagResources",<br/>    "rds:TagResources",<br/>    "rds:ModifyInstanceAutoRenewalAttribute",<br/>    "rds:ModifySecurityGroupConfiguration",<br/>    "rds:ModifyDBInstance*",<br/>    "rds:DescribeDBInstance*",<br/>    "rds:DescribeTags",<br/>    "rds:DescribeSQLCollector*",<br/>    "rds:DescribeParameters",<br/>    "rds:DescribeInstanceAutoRenewalAttribute",<br/>    "rds:DescribeSecurityGroupConfiguration"<br/>  ],<br/>  "disk-all": [<br/>    "ecs:*Disk*",<br/>    "ecs:UntagResources",<br/>    "ecs:TagResources",<br/>    "ecs:DescribeZones"<br/>  ],<br/>  "disk-attach": [<br/>    "ecs:AttachDisk",<br/>    "ecs:DescribeDisks",<br/>    "ecs:ModifyDiskAttribute"<br/>  ],<br/>  "disk-create": [<br/>    "ecs:CreateDisk",<br/>    "ecs:UntagResources",<br/>    "ecs:TagResources",<br/>    "ecs:ModifyDiskAttribute",<br/>    "ecs:DescribeDisks",<br/>    "ecs:DescribeZones"<br/>  ],<br/>  "disk-delete": [<br/>    "ecs:DeleteDisk",<br/>    "ecs:DescribeDisks"<br/>  ],<br/>  "disk-detach": [<br/>    "ecs:DetachDisk",<br/>    "ecs:DescribeDisks"<br/>  ],<br/>  "disk-read": [<br/>    "ecs:DescribeDisks"<br/>  ],<br/>  "disk-update": [<br/>    "ecs:UntagResources",<br/>    "ecs:TagResources",<br/>    "ecs:ModifyDiskAttribute",<br/>    "ecs:ResizeDisk",<br/>    "ecs:DescribeDisks"<br/>  ],<br/>  "eip-all": [<br/>    "vpc:*EipAddress*",<br/>    "vpc:UntagResources",<br/>    "vpc:TagResources"<br/>  ],<br/>  "eip-associate": [<br/>    "vpc:AssociateEipAddress",<br/>    "vpc:DescribeEipAddresses"<br/>  ],<br/>  "eip-create": [<br/>    "vpc:AllocateEipAddress",<br/>    "vpc:UntagResources",<br/>    "vpc:TagResources",<br/>    "vpc:ModifyEipAddressAttribute",<br/>    "vpc:DescribeEipAddresses"<br/>  ],<br/>  "eip-delete": [<br/>    "vpc:ReleaseEipAddress",<br/>    "vpc:DescribeEipAddresses"<br/>  ],<br/>  "eip-read": [<br/>    "vpc:DescribeEipAddresses"<br/>  ],<br/>  "eip-unassociate": [<br/>    "vpc:UnassociateEipAddress",<br/>    "vpc:DescribeEipAddresses"<br/>  ],<br/>  "eip-update": [<br/>    "vpc:UntagResources",<br/>    "vpc:TagResources",<br/>    "vpc:ModifyEipAddressAttribute",<br/>    "vpc:DescribeEipAddresses"<br/>  ],<br/>  "image-all": [<br/>    "ecs:*Image*",<br/>    "ecs:DescribeInstances",<br/>    "ecs:DescribeSnapshots"<br/>  ],<br/>  "image-copy": [<br/>    "ecs:CopyImage",<br/>    "ecs:DescribeImages"<br/>  ],<br/>  "image-create": [<br/>    "ecs:DescribeInstances",<br/>    "ecs:DescribeSnapshots",<br/>    "ecs:CreateImage",<br/>    "ecs:DescribeImages"<br/>  ],<br/>  "image-delete": [<br/>    "ecs:DeleteImage",<br/>    "ecs:DescribeImages"<br/>  ],<br/>  "image-export": [<br/>    "ecs:ExportImage",<br/>    "ecs:DescribeImages"<br/>  ],<br/>  "image-import": [<br/>    "ecs:ImportImage",<br/>    "ecs:DescribeImages"<br/>  ],<br/>  "image-read": [<br/>    "ecs:DescribeImages"<br/>  ],<br/>  "image-share": [<br/>    "ecs:*ImageSharePermission"<br/>  ],<br/>  "image-update": [<br/>    "ecs:ModifyImageAttribute",<br/>    "ecs:DescribeImages"<br/>  ],<br/>  "instance-all": [<br/>    "ecs:*Instance*",<br/>    "ecs:TagResources",<br/>    "ecs:UntagResources",<br/>    "ecs:DecribeInstance*",<br/>    "ecs:JoinSecurityGroup",<br/>    "ecs:LeaveSecurityGroup",<br/>    "ecs:AttachKeyPair",<br/>    "ecs:ReplaceSystemDisk",<br/>    "ecs:AllocatePublicIpAddress",<br/>    "ecs:DescribeUserData"<br/>  ],<br/>  "instance-create": [<br/>    "ecs:DescribeAvailableResource",<br/>    "vpc:DescribeVSwitchAttributes",<br/>    "ecs:DescribeZones",<br/>    "ecs:DescribeSecurityGroupAttribute",<br/>    "ecs:RunInstances",<br/>    "ecs:UntagResources",<br/>    "ecs:TagResources",<br/>    "ecs:DescribeDisks",<br/>    "ecs:JoinSecurityGroup",<br/>    "ecs:LeaveSecurityGroup",<br/>    "kms:Decrypt",<br/>    "ecs:ModifyInstanceAutoReleaseTime",<br/>    "ecs:ModifyInstanceAutoRenewAttribute",<br/>    "ecs:DescribeInstances",<br/>    "ecs:DescribeUserData",<br/>    "ecs:DescribeInstanceRamRole",<br/>    "ecs:DescribeInstanceAutoRenewAttribute"<br/>  ],<br/>  "instance-delete": [<br/>    "ecs:DeleteInstance",<br/>    "ecs:ModifyInstanceChargeType",<br/>    "ecs:StopInstance",<br/>    "ecs:DescribeInstances"<br/>  ],<br/>  "instance-read": [<br/>    "ecs:DescribeInstances",<br/>    "ecs:DescribeUserData",<br/>    "ecs:DescribeInstanceRamRole",<br/>    "ecs:DescribeInstanceAutoRenewAttribute"<br/>  ],<br/>  "instance-update": [<br/>    "ecs:UntagResources",<br/>    "ecs:TagResources",<br/>    "ecs:DescribeDisks",<br/>    "ecs:JoinSecurityGroup",<br/>    "ecs:LeaveSecurityGroup",<br/>    "ecs:AttachKeyPair",<br/>    "ecs:ModifyInstance*",<br/>    "ecs:ReplaceSystemDisk",<br/>    "ecs:ModifyPrepayInstanceSpec",<br/>    "ecs:StopInstance",<br/>    "ecs:StartInstance",<br/>    "ecs:AllocatePublicIpAddress",<br/>    "ecs:DescribeInstances",<br/>    "ecs:DescribeUserData",<br/>    "ecs:DescribeInstanceRamRole",<br/>    "ecs:DescribeInstanceAutoRenewAttribute"<br/>  ],<br/>  "oss-bucket-all": [<br/>    "oss:*Bucket*"<br/>  ],<br/>  "oss-bucket-create": [<br/>    "oss:ListBuckets",<br/>    "oss:CreateBucket",<br/>    "oss:SetBucketACL",<br/>    "oss:*BucketCORS",<br/>    "oss:*BucketWebsite",<br/>    "oss:*BucketLogging",<br/>    "oss:*BucketReferer",<br/>    "oss:*BucketLifecycle",<br/>    "oss:*BucketEncryption",<br/>    "oss:*BucketTagging",<br/>    "oss:SetBucketVersioning",<br/>    "oss:GetBucketInfo"<br/>  ],<br/>  "oss-bucket-delete": [<br/>    "oss:ListBuckets",<br/>    "oss:DeleteBucket",<br/>    "oss:GetBucketInfo"<br/>  ],<br/>  "oss-bucket-read": [<br/>    "oss:GetBucket*"<br/>  ],<br/>  "oss-bucket-update": [<br/>    "oss:SetBucketACL",<br/>    "oss:*BucketCORS",<br/>    "oss:*BucketWebsite",<br/>    "oss:*BucketLogging",<br/>    "oss:*BucketReferer",<br/>    "oss:*BucketLifecycle",<br/>    "oss:*BucketEncryption",<br/>    "oss:*BucketTagging",<br/>    "oss:SetBucketVersioning",<br/>    "oss:GetBucketInfo"<br/>  ],<br/>  "security-group-all": [<br/>    "ecs:*SecurityGroup*",<br/>    "ecs:UntagResources",<br/>    "ecs:TagResources"<br/>  ],<br/>  "security-group-create": [<br/>    "ecs:CreateSecurityGroup",<br/>    "ecs:UntagResources",<br/>    "ecs:TagResources",<br/>    "ecs:ModifySecurityGroupPolicy",<br/>    "ecs:Describe*"<br/>  ],<br/>  "security-group-delete": [<br/>    "ecs:DeleteSecurityGroup",<br/>    "ecs:DescribeSecurityGroupAttribute"<br/>  ],<br/>  "security-group-read": [<br/>    "ecs:DescribeSecurityGroupAttribute",<br/>    "ecs:DescribeSecurityGroups",<br/>    "ecs:DescribeTags"<br/>  ],<br/>  "security-group-rule-all": [<br/>    "ecs:AuthorizeSecurityGroup*",<br/>    "ecs:ModifySecurityGroupRule",<br/>    "ecs:ModifySecurityGroupEgressRule",<br/>    "ecs:RevokeSecurityGroup*",<br/>    "ecs:DescribeSecurityGroupAttribute"<br/>  ],<br/>  "security-group-rule-create": [<br/>    "ecs:AuthorizeSecurityGroup*",<br/>    "ecs:DescribeSecurityGroupAttribute"<br/>  ],<br/>  "security-group-rule-delete": [<br/>    "ecs:RevokeSecurityGroup*",<br/>    "ecs:DescribeSecurityGroupAttribute"<br/>  ],<br/>  "security-group-rule-read": [<br/>    "ecs:DescribeSecurityGroupAttribute"<br/>  ],<br/>  "security-group-rule-update": [<br/>    "ecs:ModifySecurityGroupRule",<br/>    "ecs:ModifySecurityGroupEgressRule",<br/>    "ecs:DescribeSecurityGroupAttribute"<br/>  ],<br/>  "security-group-update": [<br/>    "ecs:UntagResources",<br/>    "ecs:TagResources",<br/>    "ecs:ModifySecurityGroupPolicy",<br/>    "ecs:Describe*"<br/>  ],<br/>  "slb-all": [<br/>    "slb:*LoadBalancer*",<br/>    "slb:UntagResources",<br/>    "slb:TagResources",<br/>    "slb:ListTagResources"<br/>  ],<br/>  "slb-create": [<br/>    "slb:CreateLoadBalancer",<br/>    "slb:UntagResources",<br/>    "slb:TagResources",<br/>    "slb:DescribeLoadBalancerAttribute",<br/>    "slb:ListTagResources"<br/>  ],<br/>  "slb-delete": [<br/>    "slb:DeleteLoadBalancer",<br/>    "slb:DescribeLoadBalancerAttribute"<br/>  ],<br/>  "slb-read": [<br/>    "slb:DescribeLoadBalancerAttribute",<br/>    "slb:ListTagResources"<br/>  ],<br/>  "slb-update": [<br/>    "slb:UntagResources",<br/>    "slb:TagResources",<br/>    "slb:SetLoadBalancer*",<br/>    "slb:ModifyLoadBalancer*",<br/>    "slb:DescribeLoadBalancerAttribute",<br/>    "slb:ListTagResources"<br/>  ],<br/>  "vpc-all": [<br/>    "vpc:*Vpc*",<br/>    "vpc:UntagResources",<br/>    "vpc:TagResources",<br/>    "vpc:ListTagResources",<br/>    "vpc:DescribeVpcAttribute",<br/>    "vpc:DescribeRouteTables"<br/>  ],<br/>  "vpc-create": [<br/>    "vpc:CreateVpc",<br/>    "vpc:UntagResources",<br/>    "vpc:TagResources",<br/>    "vpc:ModifyVpcAttribute",<br/>    "vpc:DescribeVpcAttribute",<br/>    "vpc:ListTagResources",<br/>    "vpc:DescribeRouteTables"<br/>  ],<br/>  "vpc-delete": [<br/>    "vpc:DeleteVpc",<br/>    "vpc:DescribeVpcAttribute"<br/>  ],<br/>  "vpc-read": [<br/>    "vpc:DescribeVpcAttribute",<br/>    "vpc:ListTagResources",<br/>    "vpc:DescribeRouteTables"<br/>  ],<br/>  "vpc-update": [<br/>    "vpc:UntagResources",<br/>    "vpc:TagResources",<br/>    "vpc:ModifyVpcAttribute",<br/>    "vpc:DescribeVpcAttribute",<br/>    "vpc:ListTagResources",<br/>    "vpc:DescribeRouteTables"<br/>  ],<br/>  "vswitch-create": [<br/>    "vpc:CreateVSwitch",<br/>    "vpc:UntagResources",<br/>    "vpc:TagResources",<br/>    "vpc:DescribeVSwitchAttributes",<br/>    "vpc:ListTagResources"<br/>  ],<br/>  "vswitch-delete": [<br/>    "vpc:DeleteVSwitch",<br/>    "vpc:DescribeVSwitchAttributes"<br/>  ],<br/>  "vswitch-read": [<br/>    "vpc:DescribeVSwitchAttributes",<br/>    "vpc:ListTagResources"<br/>  ],<br/>  "vswitch-update": [<br/>    "vpc:UntagResources",<br/>    "vpc:TagResources",<br/>    "vpc:ModifyVSwitchAttribute",<br/>    "vpc:DescribeVSwitchAttributes",<br/>    "vpc:ListTagResources"<br/>  ],<br/>  "vswithch-all": [<br/>    "vpc:*VSwitch*",<br/>    "vpc:UntagResources",<br/>    "vpc:TagResources",<br/>    "vpc:ListTagResources"<br/>  ]<br/>}</pre> | no |
| <a name="input_policies"></a> [policies](#input\_policies) | (Deprecated, use alicloud\_ram\_policy\_document data source instead) List Map of known policy actions. Each item can include the following field: `name`(the policy name prefix, default to a name with 'terraform-ram-policy-' prefix), `actions`(list of the custom actions used to create a ram policy), `defined_actions`(list of the defined actions used to create a ram policy), `resources`(list of the resources used to create a ram policy, default to [*]), `effect`(Allow or Deny, default to Allow), `force`(whether to delete ram policy forcibly, default to true). | `list(map(string))` | `[]` | no |
| <a name="input_profile"></a> [profile](#input\_profile) | (Deprecated from version 1.1.0) The profile name as set in the shared credentials file. If not set, it will be sourced from the ALICLOUD\_PROFILE environment variable. | `string` | `""` | no |
| <a name="input_region"></a> [region](#input\_region) | (Deprecated from version 1.1.0) The region used to launch this module resources. | `string` | `""` | no |
| <a name="input_shared_credentials_file"></a> [shared\_credentials\_file](#input\_shared\_credentials\_file) | (Deprecated from version 1.1.0) This is the path to the shared credentials file. If this is not set and a profile is specified, $HOME/.aliyun/config.json will be used. | `string` | `""` | no |
| <a name="input_skip_region_validation"></a> [skip\_region\_validation](#input\_skip\_region\_validation) | (Deprecated from version 1.1.0) Skip static validation of region ID. Used by users of alternative AlibabaCloud-like APIs or users w/ access to regions that are not public (yet). | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_policy_id"></a> [policy\_id](#output\_policy\_id) | Id of the custom policy |
| <a name="output_policy_name"></a> [policy\_name](#output\_policy\_name) | Name of the custom policy |
| <a name="output_this_policy_id"></a> [this\_policy\_id](#output\_this\_policy\_id) | (Deprecated, use 'policy\_id') Id of the custom policy |
| <a name="output_this_policy_name"></a> [this\_policy\_name](#output\_this\_policy\_name) | (Deprecated, use 'policy\_name') Name of the custom policy |
<!-- END_TF_DOCS -->

作者
-------
Created and maintained by Alibaba Cloud Terraform Team(terraform@alibabacloud.com)

许可
----
Apache 2 Licensed. See LICENSE for full details.

参考
---------
* [Terraform-Provider-Alicloud Github](https://github.com/terraform-providers/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://www.terraform.io/docs/providers/alicloud/index.html)

