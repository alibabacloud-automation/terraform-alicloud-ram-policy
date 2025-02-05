Terraform module which create RAM policies on Alibaba Cloud.
terraform-alicloud-ram-policy

English | [简体中文](./README-CN.md)

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

* [PowerUserAccess](./modules/PowerUserAccess)([example](./examples/PowerUserAccess)) - Power user, who is responsible for enterprise cloud operation, can create and view and operate all cloud services, can NOT manage identity permissions, can NOT manage account structure, can NOT use financial center.
* [FinanceStaff](./modules/FinanceStaff)([example](./examples/FinanceStaff)) - Finance staff, who is responsible for financial work of the enterprise, can view bills, recharge and pay, invoice, etc., can use financial analysis, and has all permissions for financial account system.
* [NetworkAdministrator](./modules/NetworkAdministrator)([example](./examples/NetworkAdministrator)) - Network Administrator, who is responsible for building and managing the network architecture of enterprise, can open and create network services, has all permissions for network services and ECS security groups.
* [DatabaseAdministrator](./modules/DatabaseAdministrator)([example](./examples/DatabaseAdministrator)) - Database administrator, who is responsible for enterprise databases operation, can open and create database services, and has all permissions for database services.
* [SecurityAdministrator](./modules/SecurityAdministrator)([example](./examples/SecurityAdministrator)) - Security administrator, who is responsible for enterprise cloud security, can open and create cloud security services, develop and implement security rules, has all permissions for security services.
* [AuditAdministrator](./modules/AuditAdministrator)([example](./examples/AuditAdministrator)) - Auditing administrator, who can access Cloud Config, ActionTrail, SLS and describe all cloud resources.
* [EcsFullAccessDenySecurityChange](./modules/EcsFullAccessDenySecurityChange)([example](./examples/EcsFullAccessDenySecurityChange)) - Allow to full access ECS service and deny to create or update or delete security groups.
* [RdsFullAccessDenySecurityChange](./modules/RdsFullAccessDenySecurityChange)([example](./examples/RdsFullAccessDenySecurityChange)) - Allow to full access RDS service and deny to modify security settings.
* [EcsInstanceReboot](./modules/EcsInstanceReboot)([example](./examples/EcsInstanceReboot)) - Allow to list all ECS instances and reboot specified instances.
* [EcsInstanceRunCommand](./modules/EcsInstanceRunCommand)([example](./examples/EcsInstanceRunCommand)) - Allow to list all ECS instances, run and stop commands on instances.
* [RdsDbInstanceBackup](./modules/RdsDbInstanceBackup)([example](./examples/RdsDbInstanceBackup)) - Allow to list all RDS instances, create and modify backups for specified instances.
* [RedisDbInstanceAccount](./modules/RedisDbInstanceAccount)([example](./examples/RedisDbInstanceAccount)) - Allow to list all Redis instances, create account and reset password and modify securify IPs.
* [OssBucketReadOnly](./modules/OssBucketReadOnly)([example](./examples/OssBucketReadOnly)) - Allow to access resources of specified OSS bucket.
* [MnsQueueMsgConsume](./modules/MnsQueueMsgConsume)([example](./examples/MnsQueueMsgConsume)) - Allow to send to MNS queue, consume from MNS queue, set message visibility, delete messages after consumption.
* [OssBucketPutObject](./modules/OssBucketPutObject)([example](./examples/OssBucketPutObject)) - Allow to put and get objects to/from specified OSS Bucket, with no permission to delete, suitable for file upload and download scenarios.
* [OtsInstanceGetRow](./modules/OtsInstanceGetRow)([example](./examples/OtsInstanceGetRow)) - Allow to query all table data in a specified OTS instance, retrieve single row data, perform batch queries for multiple rows of data, and use secondary indexes for searching.
* [OssBucketFullAccessDenyDelete](./modules/OssBucketFullAccessDenyDelete)([example](./examples/OssBucketFullAccessDenyDelete)) - Allow to full access resources of specified OSS buckets and deny to delete any.
* [CrRepositoryPull](./modules/CrRepositoryPull)([example](./examples/CrRepositoryPull)) - Allow to list all CR namespaces and pull repositories of specified namespaces.
* [CrRepositoryFullAccess](./modules/CrRepositoryFullAccess)([example](./examples/CrRepositoryFullAccess)) - Allow to full access specified ACR repositories.
* [KmsKeyUse](./modules/KmsKeyUse)([example](./examples/KmsKeyUse)) - Allow to list and use keys.
* [KmsSecretReadOnly](./modules/KmsSecretReadOnly)([example](./examples/KmsSecretReadOnly)) - Allow to list and view all KMS secrets.
* [AlidnsDomainFullAccess](./modules/AlidnsDomainFullAccess)([example](./examples/AlidnsDomainFullAccess)) - Allow to list all domains and manage specified domains.
* [EcsFullAccessDenyBuy](./modules/EcsFullAccessDenyBuy)([example](./examples/EcsFullAccessDenyBuy)) - Allow to full access ECS service and deny to buy and renew and modify spec.
* [RdsFullAccessDenyBuy](./modules/RdsFullAccessDenyBuy)([example](./examples/RdsFullAccessDenyBuy)) - Allow to full access RDS service and deny to buy and renew.
* [RedisFullAccessDenyBuy](./modules/RedisFullAccessDenyBuy)([example](./examples/RedisFullAccessDenyBuy)) - Allow to full access Redis service and deny to buy and renew and modify spec.
* [SlbFullAccessDenyBuy](./modules/SlbFullAccessDenyBuy)([example](./examples/SlbFullAccessDenyBuy)) - Allow to full access SLB service and deny to buy and renew and modify spec.
* [BssReadOnly](./modules/BssReadOnly)([example](./examples/BssReadOnly)) - Allow to view and export orders and billing.
* [RamFullAccessOnlyMFAEnabled](./modules/RamFullAccessOnlyMFAEnabled)([example](./examples/RamFullAccessOnlyMFAEnabled)) - Allow to full access RAM and deny to access RAM if MFA disabled.
* [PostLogToSlsProject](./modules/PostLogToSlsProject)([example](./examples/PostLogToSlsProject)) - Allow to post log to specified SLS project
* [AckClusterFullAccess](./modules/AckClusterFullAccess)([example](./examples/AckClusterFullAccess)) - Allow to list and view specified ACK clusters.
* [AhasApplicaitonReadOnly](./modules/AhasApplicaitonReadOnly)([example](./examples/AhasApplicaitonReadOnly)) - Allow to access specified AHAS applications.
* [AhasApplicaitonFullAccess](./modules/AhasApplicaitonFullAccess)([example](./examples/AhasApplicaitonFullAccess)) - Allow to access specified AHAS applications and authorize AHAS.
* [MaxComputeAccessOSSBucket](./modules/MaxComputeAccessOSSBucket)([example](./examples/MaxComputeAccessOSSBucket)) - Allow MaxCompute to access specified OSS Bucket
* [MaxComputeAccessKMSKey](./modules/MaxComputeAccessKMSKey)([example](./examples/MaxComputeAccessKMSKey)) - Allow MaxCompute to encrypt or decrypt with specified KMS key

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

