Terraform module which create RAM policies on Alibaba Cloud.   
terraform-alicloud-ram-policy

English | [简体中文](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/README-CN.md)

Terraform module can create custom policies on Alibaba Cloud.

These types of resources are supported:

* [RAM policy](https://www.terraform.io/docs/providers/alicloud/r/ram_policy.html)

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

## Notes
From the version v1.1.0, the module has removed the following `provider` setting:

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

If you still want to use the `provider` setting to apply this module, you can specify a supported version, like 1.0.0:

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

If you want to upgrade the module to 1.1.0 or higher in-place, you can define a provider which same region with
previous region:

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
or specify an alias provider with a defined region to the module using `providers`:

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

and then run `terraform init` and `terraform apply` to make the defined provider effect to the existing module state.

More details see [How to use provider in the module](https://www.terraform.io/docs/language/modules/develop/providers.html#passing-providers-explicitly)

## Terraform versions

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12.0 |
| <a name="requirement_alicloud"></a> [alicloud](#requirement\_alicloud) | >= 1.56.0 |

Authors
-------
Created and maintained by Alibaba Cloud Terraform Team(terraform@alibabacloud.com)

License
----
Apache 2 Licensed. See LICENSE for full details.

Reference
---------
* [Terraform-Provider-Alicloud Github](https://github.com/terraform-providers/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://www.terraform.io/docs/providers/alicloud/index.html)

