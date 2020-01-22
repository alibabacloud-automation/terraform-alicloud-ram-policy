variable "defined_actions" {
  description = "Operations on specific resources."
  type        = map(list(string))
  default = {
    ###########################
    # ecs policy
    ###########################
    instance-create = [
      "ecs:Describe*",
      "ecs:List*",
      "vpc:Describe*",
      "ecs:RunInstances",
      "ecs:UntagResources",
      "ecs:TagResources",
      "ecs:JoinSecurityGroup",
      "ecs:LeaveSecurityGroup",
      "ecs:StartInstance",
      "ecs:StopInstance",
      "ecs:Modify*",
      "ecs:AllocatePublicIpAddress",
    ],
    instance-update = [
      "ecs:Decribe*",
      "ecs:UntagResources",
      "ecs:TagResources",
      "ecs:JoinSecurityGroup",
      "ecs:LeaveSecurityGroup",
      "ecs:AttachKeyPair",
      "ecs:Modify*",
      "ecs:StopInstance",
      "ecs:ReplaceSystemDisk",
      "ecs:StartInstance",
      "ecs:AllocatePublicIpAddress",
    ]
    instance-read   = ["ecs:Describe*", "ecs:List*"],
    instance-delete = ["ecs:DeleteInstance", "ecs:Modify*", "ecs:Describe*"]
    instance-all    = ["ecs:*Instance*", "ecs:Tag*", "ecs:Untag*", "ecs:Decribe*", "ecs:Modify*", "ecs:*SecurityGroup*", "ecs:List*", "ecs:Allocate*", "ecs:Attach*", "ecs:Replace*", "vpc:Describe*"]

    ###########################
    # security policy
    ###########################
    security-group-create = ["ecs:CreateSecurityGroup", "ecs:ModifySecurityGroupPolicy", "ecs:ProcessCommonRequest", "ecs:Describe*"]
    security-group-update = ["ecs:ModifySecurityGroupPolicy"]
    security-group-read   = ["ecs:DescribeSecurityGroupAttribute", "ecs:DescribeSecurityGroups", "ecs:DescribeTags"]
    security-group-delete = ["ecs:DeleteSecurityGroup"]
    security-group-all    = ["ecs:*SecurityGroup*", "ecs:ProcessCommonRequest", "ecs:Describe*"]

    ###########################
    # security-group-rule policy
    ###########################
    security-group-rule-create = ["ecs:DescribeSecurityGroupAttribute", "ecs:ProcessCommonRequest"]
    security-group-rule-read   = ["ecs:DescribeSecurityGroupAttribute"]
    security-group-rule-update = ["ecs:DescribeSecurityGroupAttribute", "ecs:ProcessCommonRequest"]
    security-group-rule-delete = ["ecs:ProcessCommonRequest"]
    security-group-rule-all    = ["ecs:DescribeSecurityGroupAttribute", "ecs:ProcessCommonRequest"]

    ###########################
    # vpc policy
    ###########################
    vpc-create = ["vpc:CreateVpc", "vpc:ModifyVpcAttribute", "vpc:Describe*", "vpc:ListTagResources", "vpc:DescribeRouteTables", "vpc:AssociateEipAddress", "vpc:UnassociateEipAddress", "vpc:DescribeEipAddresses"]
    vpc-update = ["vpc:ModifyVpcAttribute", "vpc:AssociateEipAddress", "vpc:UnassociateEipAddress"]
    vpc-read   = ["vpc:Describe*", "vpc:ListTagResources", "vpc:DescribeEipAddresses"]
    vpc-delete = ["vpc:DeleteVpc"]
    vpc-all    = ["vpc:*Vpc*", "vpc:List*", "vpc:Describe*", "vpc:AssociateEipAddress", "vpc:DescribeEipAddresses", "vpc:UnassociateEipAddress"]

    ###########################
    # vswitch policy
    ###########################
    vswitch-create = ["vpc:CreateVSwitch", "vpc:DescribeVSwitchAttributes", "vpc:DescribeVSwitchAttributes", "vpc:ListTagResources"]
    vswitch-update = ["vpc:ModifyVSwitchAttribute"]
    vswitch-read   = ["vpc:DescribeVSwitchAttributes", "vpc:ListTagResources"]
    vswitch-delete = ["vpc:DeleteVSwitch"]
    vswithch-all   = ["vpc:*VSwitch*", "vpc:List*"]

    ###########################
    # eip policy
    ###########################
    eip-create = ["vpc:AllocateEipAddress", "vpc:ModifyEipAddressAttribute", "vpc:DescribeEipAddresses", "vpc:ListTagResources"]
    eip-update = ["vpc:ModifyEipAddressAttribute"]
    eip-read   = ["vpc:DescribeEipAddresses", "vpc:ListTagResources"]
    eip-delete = ["vpc:ReleaseEipAddress", "vpc:DescribeEipAddresses"]
    eip-all    = ["vpc:AllocateEipAddress", "vpc:ModifyEipAddressAttribute", "vpc:DescribeEipAddresses", "vpc:ListTagResources", "vpc:ReleaseEipAddress"]

    ###########################
    # slb policy
    ###########################
    slb-create = ["slb:CreateLoadBalancer", "slb:Describe*", "slb:*Tags", "slb:Set*", "slb:Modify*"]
    slb-update = ["slb:*Tags", "slb:Set*", "slb:Modify*"]
    slb-read   = ["slb:Describe*"]
    slb-delete = ["slb:DeleteLoadBalancer", "slb:Describe*"]
    slb-all    = ["slb:CreateLoadBalancer", "slb:Describe*", "slb:*Tags", "slb:Set*", "slb:Modify*", "slb:DeleteLoadBalancer"]

    ###########################
    # rds policy
    ###########################
    rds-create = ["vpc:Describe*", "drds:CreateDrdsInstance", "drds:ModifyDrdsInstanceDescription", "drds:DescribeDrdsInstance"]
    rds-update = ["drds:ModifyDrdsInstanceDescription"]
    rds-read   = ["drds:DescribeDrdsInstance"]
    rds-delete = ["drds:RemoveDrdsInstance"]
    rds-all    = ["vpc:Describe*", "drds:CreateDrdsInstance", "drds:ModifyDrdsInstanceDescription", "drds:DescribeDrdsInstance", "drds:RemoveDrdsInstance"]

    ###########################
    # oss bucket policy
    ###########################
    oss-bucket-create  = ["oss:IsBucketExist", "oss:CreateBucket", "oss:SetBucketACL", "oss:DeleteBucket*", "oss:SetBucket*", "oss:GetBucket*", "oss:Conn.*"]
    oss-bucket-update  = ["oss:SetBucketACL", "oss:DeleteBucket*", "oss:SetBucket*"]
    oss-bucket-read    = ["oss:Get*", "oss:List*"]
    oss-bucket-deletef = ["oss:IsBucketExist", "oss:DeleteBucket", "oss:Bucket", "oss:GetBucketInfo"]
    oss-bucket-all     = ["oss:*Bucket*", "oss:Get*", "oss:List*"]

    ###########################
    # disk policy
    ###########################
    disk-create = ["ecs:Describe*", "ecs:CreateDisk", "ecs:ModifyDiskAttribute", "ecs:ResizeDisk"]
    disk-update = ["ecs:ModifyDiskAttribute", "ecs:ResizeDisk"]
    disk-read   = ["ecs:Describe*"]
    disk-delete = ["ecs:DeleteDisk", "ecs:Describe*"]
    disk-all    = ["ecs:Describe*", "ecs:CreateDisk", "ecs:ModifyDiskAttribute", "ecs:ResizeDisk", "ecs:DeleteDisk"]

    ###########################
    # image policy
    ###########################
    image-create = ["ecs:Describe*", "ecs:CreateImage", "ecs:CopyImage", "ecs:ExportImage", "ecs:ImportImage", "ecs:ModifyImageSharePermission", "ecs:DescribeImageSharePermission"]
    image-update = ["ecs:ModifyImageAttribute", "ecs:Describe*"]
    image-read   = ["ecs:Describe*"]
    image-delete = ["ecs:DeleteImage", "ecs:ModifyImageSharePermission"]
    image-all    = ["ecs:*Image*", "ecs:Describe*"]
  }
}
