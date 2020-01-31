terraform-alicloud-ram-policy
=====================================================================

中文简体 | [English](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/README.md)

Terraform模块可以在阿里云上创建自定义策略。

支持以下类型的资源：

* [RAM policy](https://www.terraform.io/docs/providers/alicloud/r/ram_policy.html)

## Terraform 版本

本 Module 要求使用 Terraform 0.12.

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


作者
-------
Created and maintained by Zhou qilin(z17810666992@163.com), He Guimin(@xiaozhu36, heguimin36@163.com)

许可
----
Apache 2 Licensed. See LICENSE for full details.

参考
---------
* [Terraform-Provider-Alicloud Github](https://github.com/terraform-providers/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://www.terraform.io/docs/providers/alicloud/index.html)

