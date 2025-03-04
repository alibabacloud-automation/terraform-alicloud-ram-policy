Terraform module which create RAM policies on Alibaba Cloud.

ram-policy
=====================================================================

English | [简体中文](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/README-CN.md)

Terraform module can create custom policies on Alibaba Cloud.

## Usage

Scenario-based strategy templates are all located in submodules. Please refer to the examples in the `examples` directory to find the submodule that suits your needs. It is not recommended to use the main module; instead, use [alicloud_ram_policy_document](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/ram_policy_document) as a substitute for the main module. The main module is retained primarily to avoid compatibility impacts for existing users.

### Basic Usage

Create a read-only policy for financial personnel (no parameters).

```hcl
module "example" {
  source = "terraform-alicloud-modules/ram-policy/alicloud//modules/BssReadOnly"
  create_policy = true
}
```

Create a read-only policy for certain OSS Object prefixes (with parameters).

```hcl
module "example" {
  source = "terraform-alicloud-modules/ram-policy/alicloud//modules/OssBucketReadOnly"
  create_policy = true
  oss_bucket_name = "bkt1"
  oss_object_names = ["foo/*", "bar/*"]
}
```

The most critical pieces of information in the output of the policy template:

* policy\_name - The name of the policy.
* policy\_document - The JSON string of the policy document (dependent on creating the policy entity).
* policy\_json - The JSON string of the policy document (available to obtain policy content without creating the policy entity).

### Specify Policy Name

By default, the policy template has a default policy name that is the same as the policy template. If you need to create multiple policies using the same template under your account, you will need to specify different policy names.

You can specify a complete policy name, like:

```hcl
module "example" {
  source = "terraform-alicloud-modules/ram-policy/alicloud//modules/OssBucketReadOnly"
  create_policy = true
  policy_name = "MyCustomPolicyName"
  oss_bucket_name = "bkt1"
  oss_object_names = ["foo/*", "bar/*"]
}
```

Alternatively, you can add a suffix to the default name, like:

```hcl
module "example" {
  source = "terraform-alicloud-modules/ram-policy/alicloud//modules/OssBucketReadOnly"
  create_policy = true
  policy_name_suffix = "-ForBucket1"
  oss_bucket_name = "bkt1"
  oss_object_names = ["foo/*", "bar/*"]
}
```

### Combine Multiple Scenarios

The policy template supports outputting only the content of the policy document (set `create_policy` to false) without creating the policy entity. Simultaneously, by using [alicloud_ram_policy_document](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/ram_policy_document), you can merge multiple policy document contents into one to create more comprehensive policies.

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

## Modules

* [PowerUserAccess](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/modules/PowerUserAccess)([example](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/examples/PowerUserAccess)) - Power user, who is responsible for enterprise cloud operation, can create and view and operate all cloud services, can NOT manage identity permissions, can NOT manage account structure, can NOT use financial center.
* [FinanceStaff](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/modules/FinanceStaff)([example](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/examples/FinanceStaff)) - Finance staff, who is responsible for financial work of the enterprise, can view bills, recharge and pay, invoice, etc., can use financial analysis, and has all permissions for financial account system.
* [NetworkAdministrator](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/modules/NetworkAdministrator)([example](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/examples/NetworkAdministrator)) - Network Administrator, who is responsible for building and managing the network architecture of enterprise, can open and create network services, has all permissions for network services and ECS security groups.
* [DatabaseAdministrator](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/modules/DatabaseAdministrator)([example](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/examples/DatabaseAdministrator)) - Database administrator, who is responsible for enterprise databases operation, can open and create database services, and has all permissions for database services.
* [SecurityAdministrator](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/modules/SecurityAdministrator)([example](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/examples/SecurityAdministrator)) - Security administrator, who is responsible for enterprise cloud security, can open and create cloud security services, develop and implement security rules, has all permissions for security services.
* [AuditAdministrator](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/modules/AuditAdministrator)([example](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/examples/AuditAdministrator)) - Auditing administrator, who can access Cloud Config, ActionTrail, SLS and describe all cloud resources.
* [EcsFullAccessDenySecurityChange](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/modules/EcsFullAccessDenySecurityChange)([example](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/examples/EcsFullAccessDenySecurityChange)) - Allow to full access ECS service and deny to create or update or delete security groups.
* [RdsFullAccessDenySecurityChange](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/modules/RdsFullAccessDenySecurityChange)([example](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/examples/RdsFullAccessDenySecurityChange)) - Allow to full access RDS service and deny to modify security settings.
* [EcsInstanceReboot](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/modules/EcsInstanceReboot)([example](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/examples/EcsInstanceReboot)) - Allow to list all ECS instances and reboot specified instances.
* [EcsInstanceRunCommand](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/modules/EcsInstanceRunCommand)([example](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/examples/EcsInstanceRunCommand)) - Allow to list all ECS instances, run and stop commands on instances.
* [RdsDbInstanceBackup](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/modules/RdsDbInstanceBackup)([example](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/examples/RdsDbInstanceBackup)) - Allow to list all RDS instances, create and modify backups for specified instances.
* [RedisDbInstanceAccount](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/modules/RedisDbInstanceAccount)([example](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/examples/RedisDbInstanceAccount)) - Allow to list all Redis instances, create account and reset password and modify securify IPs.
* [OssBucketReadOnly](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/modules/OssBucketReadOnly)([example](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/examples/OssBucketReadOnly)) - Allow to access resources of specified OSS bucket.
* [MnsQueueMsgConsume](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/modules/MnsQueueMsgConsume)([example](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/examples/MnsQueueMsgConsume)) - Allow to send to MNS queue, consume from MNS queue, set message visibility, delete messages after consumption.
* [OssBucketPutObject](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/modules/OssBucketPutObject)([example](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/examples/OssBucketPutObject)) - Allow to put and get objects to/from specified OSS Bucket, with no permission to delete, suitable for file upload and download scenarios.
* [OtsInstanceGetRow](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/modules/OtsInstanceGetRow)([example](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/examples/OtsInstanceGetRow)) - Allow to query all table data in a specified OTS instance, retrieve single row data, perform batch queries for multiple rows of data, and use secondary indexes for searching.
* [OssBucketFullAccessDenyDelete](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/modules/OssBucketFullAccessDenyDelete)([example](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/examples/OssBucketFullAccessDenyDelete)) - Allow to full access resources of specified OSS buckets and deny to delete any.
* [CrRepositoryPull](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/modules/CrRepositoryPull)([example](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/examples/CrRepositoryPull)) - Allow to list all CR namespaces and pull repositories of specified namespaces.
* [CrRepositoryFullAccess](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/modules/CrRepositoryFullAccess)([example](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/examples/CrRepositoryFullAccess)) - Allow to full access specified ACR repositories.
* [KmsKeyUse](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/modules/KmsKeyUse)([example](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/examples/KmsKeyUse)) - Allow to list and use keys.
* [KmsSecretReadOnly](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/modules/KmsSecretReadOnly)([example](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/examples/KmsSecretReadOnly)) - Allow to list and view all KMS secrets.
* [AlidnsDomainFullAccess](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/modules/AlidnsDomainFullAccess)([example](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/examples/AlidnsDomainFullAccess)) - Allow to list all domains and manage specified domains.
* [EcsFullAccessDenyBuy](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/modules/EcsFullAccessDenyBuy)([example](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/examples/EcsFullAccessDenyBuy)) - Allow to full access ECS service and deny to buy and renew and modify spec.
* [RdsFullAccessDenyBuy](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/modules/RdsFullAccessDenyBuy)([example](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/examples/RdsFullAccessDenyBuy)) - Allow to full access RDS service and deny to buy and renew.
* [RedisFullAccessDenyBuy](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/modules/RedisFullAccessDenyBuy)([example](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/examples/RedisFullAccessDenyBuy)) - Allow to full access Redis service and deny to buy and renew and modify spec.
* [SlbFullAccessDenyBuy](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/modules/SlbFullAccessDenyBuy)([example](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/examples/SlbFullAccessDenyBuy)) - Allow to full access SLB service and deny to buy and renew and modify spec.
* [BssReadOnly](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/modules/BssReadOnly)([example](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/examples/BssReadOnly)) - Allow to view and export orders and billing.
* [RamFullAccessOnlyMFAEnabled](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/modules/RamFullAccessOnlyMFAEnabled)([example](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/examples/RamFullAccessOnlyMFAEnabled)) - Allow to full access RAM and deny to access RAM if MFA disabled.
* [PostLogToSlsProject](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/modules/PostLogToSlsProject)([example](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/examples/PostLogToSlsProject)) - Allow to post log to specified SLS project
* [AckClusterFullAccess](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/modules/AckClusterFullAccess)([example](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/examples/AckClusterFullAccess)) - Allow to list and view specified ACK clusters.
* [AhasApplicaitonReadOnly](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/modules/AhasApplicaitonReadOnly)([example](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/examples/AhasApplicaitonReadOnly)) - Allow to access specified AHAS applications.
* [AhasApplicaitonFullAccess](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/modules/AhasApplicaitonFullAccess)([example](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/examples/AhasApplicaitonFullAccess)) - Allow to access specified AHAS applications and authorize AHAS.
* [MaxComputeAccessOSSBucket](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/modules/MaxComputeAccessOSSBucket)([example](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/examples/MaxComputeAccessOSSBucket)) - Allow MaxCompute to access specified OSS Bucket
* [MaxComputeAccessKMSKey](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/modules/MaxComputeAccessKMSKey)([example](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/examples/MaxComputeAccessKMSKey)) - Allow MaxCompute to encrypt or decrypt with specified KMS key

## Examples

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

