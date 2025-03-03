Terraform module which create RAM policies on Alibaba Cloud.

ram-policy
=====================================================================

简体中文 | [English](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/README.md)

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

* [PowerUserAccess](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/modules/PowerUserAccess)([example](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/examples/PowerUserAccess)) - 负责企业的云上运维管理，可创建、查看、操作所有的云服务，不能管理身份权限、不能管理账号架构、不能使用财务关联。
* [FinanceStaff](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/modules/FinanceStaff)([example](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/examples/FinanceStaff)) - 负责企业的财务工作，可查看账单、充值付款、开取发票等，可使用财务分析功能，拥有财账系统的全部权限。
* [NetworkAdministrator](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/modules/NetworkAdministrator)([example](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/examples/NetworkAdministrator)) - 负责企业的网络架构搭建和管理，可开通和购买创建网络服务，拥有网络服务的所有权限和 ECS 安全组的权限。
* [DatabaseAdministrator](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/modules/DatabaseAdministrator)([example](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/examples/DatabaseAdministrator)) - 负责企业的数据库运维管理，可开通和购买创建数据库服务，拥有数据库服务的所有权限。
* [SecurityAdministrator](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/modules/SecurityAdministrator)([example](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/examples/SecurityAdministrator)) - 负责企业云上安全，可开通和购买云安全服务，制定并实施安全规则，拥有安全服务的所有权限。
* [AuditAdministrator](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/modules/AuditAdministrator)([example](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/examples/AuditAdministrator)) - 具有配置审计、操作审计和日志管理的全部权限，同时可以查询所有阿里云资源现状。
* [EcsFullAccessDenySecurityChange](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/modules/EcsFullAccessDenySecurityChange)([example](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/examples/EcsFullAccessDenySecurityChange)) - 允许完全访问 ECS，禁止变更安全组的操作。
* [RdsFullAccessDenySecurityChange](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/modules/RdsFullAccessDenySecurityChange)([example](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/examples/RdsFullAccessDenySecurityChange)) - 允许完全访问 RDS，禁止变更数据库安全白名单 IP 的操作。
* [EcsInstanceReboot](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/modules/EcsInstanceReboot)([example](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/examples/EcsInstanceReboot)) - 允许列出所有 ECS 实例、重启指定 ECS 实例。
* [EcsInstanceRunCommand](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/modules/EcsInstanceRunCommand)([example](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/examples/EcsInstanceRunCommand)) - 允许列出所有 ECS 实例、运行和停止远程命令。
* [RdsDbInstanceBackup](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/modules/RdsDbInstanceBackup)([example](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/examples/RdsDbInstanceBackup)) - 允许列出所有 RDS 实例和备份指定 RDS 实例。
* [RedisDbInstanceAccount](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/modules/RedisDbInstanceAccount)([example](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/examples/RedisDbInstanceAccount)) - 允许为所有 Redis 实例创建账号、修改密码、设置 IP 白名单。
* [OssBucketReadOnly](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/modules/OssBucketReadOnly)([example](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/examples/OssBucketReadOnly)) - 允许通过 OSS 控制台读取指定 Bucket 的所有资源。
* [MnsQueueMsgConsume](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/modules/MnsQueueMsgConsume)([example](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/examples/MnsQueueMsgConsume)) - 允许向指定 MNS 队列写入和消费消息、设置消息可见性、消费成功后删除消息。
* [OssBucketPutObject](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/modules/OssBucketPutObject)([example](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/examples/OssBucketPutObject)) - 允许向指定的 OSS Bucket 写入并读取对象，无删除权限，适用于文件上传下载场景。
* [OtsInstanceGetRow](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/modules/OtsInstanceGetRow)([example](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/examples/OtsInstanceGetRow)) - 允许查询指定 OTS 实例中的所有表格数据，可获取单行数据，批量查询多行数据，使用多元索引进行搜索。
* [OssBucketFullAccessDenyDelete](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/modules/OssBucketFullAccessDenyDelete)([example](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/examples/OssBucketFullAccessDenyDelete)) - 允许访问指定 Bucket 所有资源，禁止删除指定资源。
* [CrRepositoryPull](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/modules/CrRepositoryPull)([example](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/examples/CrRepositoryPull)) - 允许列出全部命名空间并拉取指定命名空间的所有仓库。
* [CrRepositoryFullAccess](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/modules/CrRepositoryFullAccess)([example](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/examples/CrRepositoryFullAccess)) - 允许完全访问容器镜像服务的指定仓库。
* [KmsKeyUse](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/modules/KmsKeyUse)([example](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/examples/KmsKeyUse)) - 允许列出、查看和使用密钥。
* [KmsSecretReadOnly](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/modules/KmsSecretReadOnly)([example](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/examples/KmsSecretReadOnly)) - 允许列出和查看凭据。
* [AlidnsDomainFullAccess](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/modules/AlidnsDomainFullAccess)([example](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/examples/AlidnsDomainFullAccess)) - 允许列出所有域名并管理指定域名。
* [EcsFullAccessDenyBuy](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/modules/EcsFullAccessDenyBuy)([example](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/examples/EcsFullAccessDenyBuy)) - 允许完全访问 ECS，禁止购买、续费、变配等资金相关操作。
* [RdsFullAccessDenyBuy](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/modules/RdsFullAccessDenyBuy)([example](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/examples/RdsFullAccessDenyBuy)) - 允许完全访问 RDS，禁止购买、续费等资金相关操作。
* [RedisFullAccessDenyBuy](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/modules/RedisFullAccessDenyBuy)([example](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/examples/RedisFullAccessDenyBuy)) - 允许完全访问 Redis，禁止购买、续费、变配等资金相关操作。
* [SlbFullAccessDenyBuy](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/modules/SlbFullAccessDenyBuy)([example](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/examples/SlbFullAccessDenyBuy)) - 允许完全访问 SLB，禁止购买、续费、变配等资金相关操作。
* [BssReadOnly](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/modules/BssReadOnly)([example](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/examples/BssReadOnly)) - 允许查看费用中心，支持导出订单和账单数据。
* [RamFullAccessOnlyMFAEnabled](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/modules/RamFullAccessOnlyMFAEnabled)([example](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/examples/RamFullAccessOnlyMFAEnabled)) - 允许用户完全访问 RAM，禁止 MFA 未启用的用户访问 RAM。
* [PostLogToSlsProject](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/modules/PostLogToSlsProject)([example](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/examples/PostLogToSlsProject)) - 允许向指定日志项目投递日志。
* [AckClusterFullAccess](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/modules/AckClusterFullAccess)([example](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/examples/AckClusterFullAccess)) - 允许列出和查询指定的容器服务集群。
* [AhasApplicaitonReadOnly](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/modules/AhasApplicaitonReadOnly)([example](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/examples/AhasApplicaitonReadOnly)) - 允许查看指定 AHAS 应用。
* [AhasApplicaitonFullAccess](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/modules/AhasApplicaitonFullAccess)([example](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/examples/AhasApplicaitonFullAccess)) - 允许查看指定 AHAS 应用和授权服务启用。
* [MaxComputeAccessOSSBucket](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/modules/MaxComputeAccessOSSBucket)([example](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/examples/MaxComputeAccessOSSBucket)) - 允许 MaxCompute 访问指定 OSS Bucket。
* [MaxComputeAccessKMSKey](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/modules/MaxComputeAccessKMSKey)([example](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/examples/MaxComputeAccessKMSKey)) - 允许按照 MaxCompute 需要使用 KMS 密钥执行加解密。

## 示例

* [PowerUserAccess](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/examples/PowerUserAccess)
* [FinanceStaff](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/examples/FinanceStaff)
* [NetworkAdministrator](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/examples/NetworkAdministrator)
* [DatabaseAdministrator](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/examples/DatabaseAdministrator)
* [SecurityAdministrator](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/examples/SecurityAdministrator)
* [AuditAdministrator](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/examples/AuditAdministrator)
* [EcsFullAccessDenySecurityChange](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/examples/EcsFullAccessDenySecurityChange)
* [RdsFullAccessDenySecurityChange](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/examples/RdsFullAccessDenySecurityChange)
* [EcsInstanceReboot](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/examples/EcsInstanceReboot)
* [EcsInstanceRunCommand](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/examples/EcsInstanceRunCommand)
* [RdsDbInstanceBackup](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/examples/RdsDbInstanceBackup)
* [RedisDbInstanceAccount](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/examples/RedisDbInstanceAccount)
* [OssBucketReadOnly](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/examples/OssBucketReadOnly)
* [MnsQueueMsgConsume](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/examples/MnsQueueMsgConsume)
* [OssBucketPutObject](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/examples/OssBucketPutObject)
* [OtsInstanceGetRow](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/examples/OtsInstanceGetRow)
* [OssBucketFullAccessDenyDelete](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/examples/OssBucketFullAccessDenyDelete)
* [CrRepositoryPull](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/examples/CrRepositoryPull)
* [CrRepositoryFullAccess](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/examples/CrRepositoryFullAccess)
* [KmsKeyUse](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/examples/KmsKeyUse)
* [KmsSecretReadOnly](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/examples/KmsSecretReadOnly)
* [AlidnsDomainFullAccess](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/examples/AlidnsDomainFullAccess)
* [EcsFullAccessDenyBuy](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/examples/EcsFullAccessDenyBuy)
* [RdsFullAccessDenyBuy](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/examples/RdsFullAccessDenyBuy)
* [RedisFullAccessDenyBuy](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/examples/RedisFullAccessDenyBuy)
* [SlbFullAccessDenyBuy](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/examples/SlbFullAccessDenyBuy)
* [BssReadOnly](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/examples/BssReadOnly)
* [RamFullAccessOnlyMFAEnabled](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/examples/RamFullAccessOnlyMFAEnabled)
* [PostLogToSlsProject](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/examples/PostLogToSlsProject)
* [AckClusterFullAccess](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/examples/AckClusterFullAccess)
* [AhasApplicaitonReadOnly](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/examples/AhasApplicaitonReadOnly)
* [AhasApplicaitonFullAccess](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/examples/AhasApplicaitonFullAccess)
* [MaxComputeAccessOSSBucket](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/examples/MaxComputeAccessOSSBucket)
* [MaxComputeAccessKMSKey](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/examples/MaxComputeAccessKMSKey)
* [complete](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/examples/complete)

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

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |

## Providers

No providers.

## Modules

No modules.

## Resources

No resources.

## Inputs

No inputs.

## Outputs

No outputs.
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

