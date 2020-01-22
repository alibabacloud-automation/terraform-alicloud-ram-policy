# terraform-alicloud-ram-policy
Terraform module which create RAM policies on Alibaba Cloud.

=====================================================================

English | [简体中文](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/README-CN.md)

Terraform module can create custom policies on Alibaba Cloud.

These types of resources are supported:

* [RAM policy](https://www.terraform.io/docs/providers/alicloud/r/ram_policy.html)

## Terraform versions

For Terraform 0.12.

## Usage

#### Create policy using terraform default actions 

```hcl
module "instance_policy" {
  source = "terraform-alicloud-modules/ram-policy/alicloud"
  policies = [
    {
       # name is the name of the policy, if not specified, the system will generate names prefixed with `terraform_ram_policy_` by default
       name = "test"
       # defined_action is the default resource operation specified by the system. You can refer to the `policies.tf` file.
       defined_action   = join(",", ["instance-create", "vpc-create", "vswitch-create", "security-group-create"])
       effect           = "Allow"
       force            = "true"
    }
  ]
}
```

#### Create policies with custom actions and resources

```hcl
module "instance_policy" {
  source = "terraform-alicloud-modules/ram-policy/alicloud"
  policies = [
    {
        #actions is the action of custom specific resource.
        #resources is the specific object authorized to customize.
        actions    = join(",", ["ecs:xxxx", "vpc:xxxx", "vswitch:xxxe"])
        resources  = join(",", ["xxx:ecs:xxxx", "xxx:vpc:xxxx", "xxx:vswitch:xxxe"])
        effect     = "Deny"
    }
  ]
}
```

#### Create policies using terraform's default and custom actions resources

```hcl
module "instance_policy" {
  source = "terraform-alicloud-modules/ram-policy/alicloud"
  policies = [
    {
    actions          = join(",", ["ecs:xxxx", "vpc:xxxx", "vswitch:xxxe"])
    resources        = join(",", ["xxx:ecs:xxxx", "xxx:vpc:xxxx", "xxx:vswitch:xxxe"])
    defined_action   = join(",", ["instance-create", "vpc-create", "vswitch-create", "security-group-create"])
    defined_resource = join(",", ["instance-resource", "vpc-resource", "security-group-resource", "vswitch-resource"])
    effect           = "Allow"
    }
  ]
}
```


## Examples

* [ecs-instance-policy example](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/tree/master/examples/ecs-instance-create)

Authors
-------
Created and maintained by Zhou qilin(z17810666992@163.com), He Guimin(@xiaozhu36, heguimin36@163.com)

License
----
Apache 2 Licensed. See LICENSE for full details.

Reference
---------
* [Terraform-Provider-Alicloud Github](https://github.com/terraform-providers/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://www.terraform.io/docs/providers/alicloud/index.html)
