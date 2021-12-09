terraform-alicloud-ram-policy
=====================================================================

中文简体 | [English](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/README.md)

Terraform模块可以在阿里云上创建自定义策略。

支持以下类型的资源：

* [RAM policy](https://www.terraform.io/docs/providers/alicloud/r/ram_policy.html)

## 用法

```hcl
module "ram-policy" {
  source = "terraform-alicloud-modules/ram-policy/alicloud"
  policies = [
    #########################################
    # 使用预定义的 Policy Actions 创建自定义策略 #
    #########################################
    {
       # 自定义policy名称。默认为一个以terraform-ram-policy-为前缀的名称。
       name = "test"
       # 预定义的Actions。文件 policies.tf 预定义了一些terraform相关的actions
       defined_actions = join(",", ["instance-create", "vpc-create", "vswitch-create", "security-group-create"])
       effect          = "Allow"
       force           = "true"
    },

    #########################################
    # 使用自定义的 Policy Actions 创建自定义策略 #
    #########################################
    {
        actions   = join(",", ["ecs:ModifyInstanceAttribute", "vpc:ModifyVpc", "vswitch:ModifyVSwitch"])
        resources = join(",", ["acs:ecs:*:*:instance/i-001", "acs:vpc:*:*:vpc/v-001", "acs:vpc:*:*:vswitch/vsw-001"])
        effect    = "Deny"
    },
    
    ###################################################
    # 同时使用预定义和自定义的 Policy Actions 创建自定义策略 #
    ################################################### 
    {
        defined_actions = join(",", ["security-group-read", "security-group-rule-read"])
        actions         = join(",", ["ecs:JoinSecurityGroup", "ecs:LeaveSecurityGroup"])
        resources       = join(",", ["acs:ecs:cn-qingdao:*:instance/*", "acs:ecs:cn-qingdao:*:security-group/*"])
        effect          = "Allow"
    }
  ]
}
```

## 示例

* [完整的 Ram Policy 示例](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/tree/master/examples/complete)

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

## Terraform 版本

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12.0 |
| <a name="requirement_alicloud"></a> [alicloud](#requirement\_alicloud) | >= 1.56.0 |

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

