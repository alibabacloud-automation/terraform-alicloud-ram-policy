variable "defined_actions" {
  description = "Map of several defined actions"
  type        = map(list(string))
  default = {
    ###########################
    # resource ecs instance policy
    ###########################
    instance-create = [
      "ecs:DescribeAvailableResource",
      "vpc:DescribeVSwitchAttributes",
      "ecs:DescribeZones",
      "ecs:DescribeSecurityGroupAttribute",
      "ecs:RunInstances",
      "ecs:UntagResources",
      "ecs:TagResources",
      "ecs:DescribeDisks",
      "ecs:JoinSecurityGroup",
      "ecs:LeaveSecurityGroup",
      "kms:Decrypt",
      "ecs:ModifyInstanceAutoReleaseTime",
      "ecs:ModifyInstanceAutoRenewAttribute",
      "ecs:DescribeInstances",
      "ecs:DescribeUserData",
      "ecs:DescribeInstanceRamRole",
      "ecs:DescribeInstanceAutoRenewAttribute"
    ],
    instance-update = [
      "ecs:UntagResources",
      "ecs:TagResources",
      "ecs:DescribeDisks",
      "ecs:JoinSecurityGroup",
      "ecs:LeaveSecurityGroup",
      "ecs:AttachKeyPair",
      "ecs:ModifyInstance*",
      "ecs:ReplaceSystemDisk",
      "ecs:ModifyPrepayInstanceSpec",
      "ecs:StopInstance",
      "ecs:StartInstance",
      "ecs:AllocatePublicIpAddress",
      "ecs:DescribeInstances",
      "ecs:DescribeUserData",
      "ecs:DescribeInstanceRamRole",
      "ecs:DescribeInstanceAutoRenewAttribute"
    ]
    instance-read = [
      "ecs:DescribeInstances",
      "ecs:DescribeUserData",
      "ecs:DescribeInstanceRamRole",
      "ecs:DescribeInstanceAutoRenewAttribute"
    ]
    instance-delete = [
      "ecs:DeleteInstance",
      "ecs:ModifyInstanceChargeType",
      "ecs:StopInstance",
      "ecs:DescribeInstances"
    ]
    instance-all = [
      "ecs:*Instance*",
      "ecs:TagResources",
      "ecs:UntagResources",
      "ecs:DecribeInstance*",
      "ecs:JoinSecurityGroup",
      "ecs:LeaveSecurityGroup",
      "ecs:AttachKeyPair",
      "ecs:ReplaceSystemDisk",
      "ecs:AllocatePublicIpAddress",
      "ecs:DescribeUserData",
    ]

    ###########################
    # resource security group policy
    ###########################
    security-group-create = [
      "ecs:CreateSecurityGroup",
      "ecs:UntagResources",
      "ecs:TagResources",
      "ecs:ModifySecurityGroupPolicy",
      "ecs:Describe*"
    ]
    security-group-update = [
      "ecs:UntagResources",
      "ecs:TagResources",
      "ecs:ModifySecurityGroupPolicy",
      "ecs:Describe*"
    ]
    security-group-read = [
      "ecs:DescribeSecurityGroupAttribute",
      "ecs:DescribeSecurityGroups",
      "ecs:DescribeTags"
    ]
    security-group-delete = [
      "ecs:DeleteSecurityGroup",
      "ecs:DescribeSecurityGroupAttribute"
    ]
    security-group-all = [
      "ecs:*SecurityGroup*",
      "ecs:UntagResources",
      "ecs:TagResources"
    ]

    ###########################
    # resource security-group-rule policy
    ###########################
    security-group-rule-create = ["ecs:AuthorizeSecurityGroup*", "ecs:DescribeSecurityGroupAttribute"]
    security-group-rule-read   = ["ecs:DescribeSecurityGroupAttribute"]
    security-group-rule-update = [
      "ecs:ModifySecurityGroupRule",
      "ecs:ModifySecurityGroupEgressRule",
      "ecs:DescribeSecurityGroupAttribute"
    ]
    security-group-rule-delete = ["ecs:RevokeSecurityGroup*", "ecs:DescribeSecurityGroupAttribute"]
    security-group-rule-all = [
      "ecs:AuthorizeSecurityGroup*",
      "ecs:ModifySecurityGroupRule",
      "ecs:ModifySecurityGroupEgressRule",
      "ecs:RevokeSecurityGroup*",
      "ecs:DescribeSecurityGroupAttribute"
    ]

    ###########################
    # resource disk policy
    ###########################
    disk-create = [
      "ecs:CreateDisk",
      "ecs:UntagResources",
      "ecs:TagResources",
      "ecs:ModifyDiskAttribute",
      "ecs:DescribeDisks",
      "ecs:DescribeZones"
    ]
    disk-update = [
      "ecs:UntagResources",
      "ecs:TagResources",
      "ecs:ModifyDiskAttribute",
      "ecs:ResizeDisk",
      "ecs:DescribeDisks"
    ]
    disk-read   = ["ecs:DescribeDisks"]
    disk-delete = ["ecs:DeleteDisk", "ecs:DescribeDisks"]
    disk-attach = [
      "ecs:AttachDisk",
      "ecs:DescribeDisks",
      "ecs:ModifyDiskAttribute"
    ]
    disk-detach = ["ecs:DetachDisk", "ecs:DescribeDisks"]
    disk-all    = ["ecs:*Disk*", "ecs:UntagResources", "ecs:TagResources", "ecs:DescribeZones"]

    ###########################
    # resource image policy
    ###########################
    image-create = [
      "ecs:DescribeInstances",
      "ecs:DescribeSnapshots",
      "ecs:CreateImage",
      "ecs:DescribeImages"
    ]
    image-update = ["ecs:ModifyImageAttribute", "ecs:DescribeImages"]
    image-read   = ["ecs:DescribeImages"]
    image-copy   = ["ecs:CopyImage", "ecs:DescribeImages"]
    image-import = ["ecs:ImportImage", "ecs:DescribeImages"]
    image-export = ["ecs:ExportImage", "ecs:DescribeImages"]
    image-share  = ["ecs:*ImageSharePermission"]
    image-delete = ["ecs:DeleteImage", "ecs:DescribeImages"]
    image-all = [
      "ecs:*Image*",
      "ecs:DescribeInstances",
      "ecs:DescribeSnapshots"
    ]

    ###########################
    # resource vpc policy
    ###########################
    vpc-create = [
      "vpc:CreateVpc",
      "vpc:UntagResources",
      "vpc:TagResources",
      "vpc:ModifyVpcAttribute",
      "vpc:DescribeVpcAttribute",
      "vpc:ListTagResources",
      "vpc:DescribeRouteTables"
    ]
    vpc-update = [
      "vpc:UntagResources",
      "vpc:TagResources",
      "vpc:ModifyVpcAttribute",
      "vpc:DescribeVpcAttribute",
      "vpc:ListTagResources",
      "vpc:DescribeRouteTables"
    ]
    vpc-read = [
      "vpc:DescribeVpcAttribute",
      "vpc:ListTagResources",
      "vpc:DescribeRouteTables"
    ]
    vpc-delete = ["vpc:DeleteVpc", "vpc:DescribeVpcAttribute"]
    vpc-all = [
      "vpc:*Vpc*",
      "vpc:UntagResources",
      "vpc:TagResources",
      "vpc:ListTagResources",
      "vpc:DescribeVpcAttribute",
      "vpc:DescribeRouteTables"
    ]

    ###########################
    # resource vswitch policy
    ###########################
    vswitch-create = [
      "vpc:CreateVSwitch",
      "vpc:UntagResources",
      "vpc:TagResources",
      "vpc:DescribeVSwitchAttributes",
      "vpc:ListTagResources"
    ]
    vswitch-update = [
      "vpc:UntagResources",
      "vpc:TagResources",
      "vpc:ModifyVSwitchAttribute",
      "vpc:DescribeVSwitchAttributes",
      "vpc:ListTagResources"
    ]
    vswitch-read   = ["vpc:DescribeVSwitchAttributes", "vpc:ListTagResources"]
    vswitch-delete = ["vpc:DeleteVSwitch", "vpc:DescribeVSwitchAttributes"]
    vswithch-all = [
      "vpc:*VSwitch*",
      "vpc:UntagResources",
      "vpc:TagResources",
      "vpc:ListTagResources"
    ]

    ###########################
    # resource eip policy
    ###########################
    eip-create = [
      "vpc:AllocateEipAddress",
      "vpc:UntagResources",
      "vpc:TagResources",
      "vpc:ModifyEipAddressAttribute",
      "vpc:DescribeEipAddresses"
    ]
    eip-update = [
      "vpc:UntagResources",
      "vpc:TagResources",
      "vpc:ModifyEipAddressAttribute",
      "vpc:DescribeEipAddresses"
    ]
    eip-read        = ["vpc:DescribeEipAddresses"]
    eip-delete      = ["vpc:ReleaseEipAddress", "vpc:DescribeEipAddresses"]
    eip-associate   = ["vpc:AssociateEipAddress", "vpc:DescribeEipAddresses"]
    eip-unassociate = ["vpc:UnassociateEipAddress", "vpc:DescribeEipAddresses"]
    eip-delete      = ["vpc:ReleaseEipAddress", "vpc:DescribeEipAddresses"]
    eip-all = [
      "vpc:*EipAddress*",
      "vpc:UntagResources",
      "vpc:TagResources"
    ]

    ###########################
    # resource slb policy
    ###########################
    slb-create = [
      "slb:CreateLoadBalancer",
      "slb:UntagResources",
      "slb:TagResources",
      "slb:DescribeLoadBalancerAttribute",
      "slb:ListTagResources"
    ]
    slb-update = [
      "slb:UntagResources",
      "slb:TagResources",
      "slb:SetLoadBalancer*",
      "slb:ModifyLoadBalancer*",
      "slb:DescribeLoadBalancerAttribute",
      "slb:ListTagResources"
    ]
    slb-read   = ["slb:DescribeLoadBalancerAttribute", "slb:ListTagResources"]
    slb-delete = ["slb:DeleteLoadBalancer", "slb:DescribeLoadBalancerAttribute"]
    slb-all = [
      "slb:*LoadBalancer*",
      "slb:UntagResources",
      "slb:TagResources",
      "slb:ListTagResources"
    ]

    ###########################
    # resource rds instance policy
    ###########################
    db-instance-create = [
      "rds:CreateDBInstance",
      "vpc:DescribeVSwitchAttributes",
      "rds:ModifyParameter",
      "rds:UntagResources",
      "rds:TagResources",
      "rds:ModifyInstanceAutoRenewalAttribute",
      "rds:ModifySecurityGroupConfiguration",
      "rds:ModifyDBInstance*",
      "rds:DescribeDBInstance*",
      "rds:DescribeTags",
      "rds:DescribeSQLCollector*",
      "rds:DescribeParameters",
      "rds:DescribeInstanceAutoRenewalAttribute",
      "rds:DescribeSecurityGroupConfiguration"
    ]
    db-instance-update = [
      "rds:ModifyParameter",
      "rds:UntagResources",
      "rds:TagResources",
      "rds:ModifyInstanceAutoRenewalAttribute",
      "rds:ModifySecurityGroupConfiguration",
      "rds:ModifyDBInstance*",
      "rds:DescribeDBInstance*",
      "rds:DescribeTags",
      "rds:DescribeSQLCollector*",
      "rds:DescribeParameters",
      "rds:DescribeInstanceAutoRenewalAttribute",
      "rds:DescribeSecurityGroupConfiguration"
    ]
    db-instance-read = [
      "rds:DescribeDBInstance*",
      "rds:DescribeTags",
      "rds:DescribeSQLCollector*",
      "rds:DescribeParameters",
      "rds:DescribeInstanceAutoRenewalAttribute",
      "rds:DescribeSecurityGroupConfiguration"
    ]
    db-instance-delete = ["rds:DeleteDBInstance", "rds:DescribeDBInstanceAttribute"]
    db-instance-all = [
      "rds:*Instance*",
      "rds:ModifyParameter",
      "rds:UntagResources",
      "rds:TagResources",
      "rds:ModifySecurityGroupConfiguration",
      "rds:DescribeTags",
      "rds:DescribeSQLCollector*",
      "rds:DescribeParameters",
      "rds:DescribeSecurityGroupConfiguration"
    ]

    ###########################
    # resource oss bucket policy
    ###########################
    oss-bucket-create = [
      "oss:ListBuckets",
      "oss:CreateBucket",
      "oss:SetBucketACL",
      "oss:*BucketCORS",
      "oss:*BucketWebsite",
      "oss:*BucketLogging",
      "oss:*BucketReferer",
      "oss:*BucketLifecycle",
      "oss:*BucketEncryption",
      "oss:*BucketTagging",
      "oss:SetBucketVersioning",
      "oss:GetBucketInfo"
    ]
    oss-bucket-update = [
      "oss:SetBucketACL",
      "oss:*BucketCORS",
      "oss:*BucketWebsite",
      "oss:*BucketLogging",
      "oss:*BucketReferer",
      "oss:*BucketLifecycle",
      "oss:*BucketEncryption",
      "oss:*BucketTagging",
      "oss:SetBucketVersioning",
      "oss:GetBucketInfo"
    ]
    oss-bucket-read = ["oss:GetBucket*"]
    oss-bucket-delete = [
      "oss:ListBuckets",
      "oss:DeleteBucket",
      "oss:GetBucketInfo"
    ]
    oss-bucket-all = ["oss:*Bucket*"]
  }
}
