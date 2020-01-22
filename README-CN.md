# terraform-alicloud-ram-policy
Terraform模块，可在阿里云上创建RAM策略。

=====================================================================

中文简体 | [English](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/README.md)

Terraform模块可以在阿里云上创建自定义策略。

支持以下类型的资源：

* [RAM policy](https://www.terraform.io/docs/providers/alicloud/r/ram_policy.html)

## Terraform 版本

如果您正在使用 Terraform 0.12.

## 用法

#### 使用Terraform默认的操作创建自定义策略

```hcl
module "instance_policy" {
  source = "terraform-alicloud-modules/ram-policy/alicloud"
  policies = [
    {
       # name is the name of the policy, if not specified, the system will generate names prefixed with `terraform_ram_policy_` by default
       name = "test"
       # defined_action is the default resource operation specified by the system. You can refer to the `policies.tf` file.
       defined_action   = join(",", ["instance-create", "vpc-create", "vswitch-create", "security-group-create"])
       effect             = "Allow"
       force              = "true"
    }
  ]
}
```

#### 使用自定义的操作和资源创建自定义策略

```hcl
module "instance_policy" {
  source = "terraform-alicloud-modules/ram-policy/alicloud"
  policies = [
    {
        #actions is the action of custom specific resource.
        #resources is the specific object authorized to customize.
        actions    = join(",", ["ecs:xxxx", "vpc:xxxx", "vswitch:xxxe"])
        resources  = join(",", ["xxx:ecs:xxxx", "xxx:vpc:xxxx", "xxx:vswitch:xxxe"])
        effect           = "Deny"
    }
  ]
}
```

#### 使用Terraform默认和自定义的操作结合创建自定义策略

```hcl
module "instance_policy" {
  source = "terraform-alicloud-modules/ram-policy/alicloud"
  policies = [
    {
    actions    = join(",", ["ecs:xxxx", "vpc:xxxx", "vswitch:xxxe"])
    resources  = join(",", ["xxx:ecs:xxxx", "xxx:vpc:xxxx", "xxx:vswitch:xxxe"])
    defined_action   = join(",", ["instance-create", "vpc-create", "vswitch-create", "security-group-create"])
    defined_resource = join(",", ["instance-resource", "vpc-resource", "security-group-resource", "vswitch-resource"])
    effect           = "Allow"
    }
  ]
}
```


## 示例

* [ecs-instance-policy example](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/tree/master/examples/ecs-instance-create)


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

