Terraform module which create RAM policies on Alibaba Cloud.   
terraform-alicloud-ram-policy
=====================================================================

English | [简体中文](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/README-CN.md)

Terraform module can create custom policies on Alibaba Cloud.

These types of resources are supported:

* [RAM policy](https://www.terraform.io/docs/providers/alicloud/r/ram_policy.html)

## Terraform versions

The Module requires Terraform 0.12.

## Usage

```hcl
module "ram-policy" {
  source = "terraform-alicloud-modules/ram-policy/alicloud"
  policies = [
    #########################################
    # Create policies using default actions #
    #########################################
    {
       # name is the name of the policy, default to a name with prefix `terraform-ram-policy-`
       name = "test"
       # defined_action is the default resource operation specified by the system. You can refer to the `policies.tf` file.
       defined_actions = join(",", ["instance-create", "vpc-create", "vswitch-create", "security-group-create"])
       effect          = "Allow"
       force           = "true"
    },

    ########################################
    # Create policies using custom actions #
    ########################################
    {
        #actions is the action of custom specific resource.
        #resources is the specific object authorized to customize.
        actions   = join(",", ["ecs:ModifyInstanceAttribute", "vpc:ModifyVpc", "vswitch:ModifyVSwitch"])
        resources = join(",", ["acs:ecs:*:*:instance/i-001", "acs:vpc:*:*:vpc/v-001", "acs:vpc:*:*:vswitch/vsw-001"])
        effect    = "Deny"
    },
    
    #########################################################
    # Create policies using both default and custom actions #
    #########################################################  
    {
        defined_actions = join(",", ["security-group-read", "security-group-rule-read"])
        actions         = join(",", ["ecs:JoinSecurityGroup", "ecs:LeaveSecurityGroup"])
        resources       = join(",", ["acs:ecs:cn-qingdao:*:instance/*", "acs:ecs:cn-qingdao:*:security-group/*"])
        effect          = "Allow"
    }
  ]
}
```

## Examples

* [Complete Ram Policy example](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/tree/master/examples/complete)

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

