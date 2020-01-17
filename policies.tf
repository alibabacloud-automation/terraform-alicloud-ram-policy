variable "policy_actions" {
  type = map(list(string))
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
    instance-delete = ["ecs:DeleteInstance"]
    instance-all    = ["ecs:*Instance*", "ecs:Tag*", "ecs:Untag*", "ecs:Decribe*", "ecs:Modify*", "ecs:*SecurityGroup*", "ecs:List*", "ecs:Allocate*", "ecs:Attach*", "ecs:Replace*"]

    ###########################
    # security policy
    ###########################
    security-group-create = ["ecs:CreateSecurityGroup", "ecs:ModifySecurityGroupPolicy", "ecs:ProcessCommonRequest", "ecs:Describe*"]
    security-group-update = ["ecs:ModifySecurityGroupPolicy"]
    security-group-read   = ["ecs:DescribeSecurityGroupAttribute", "ecs:DescribeSecurityGroups", "ecs:DescribeTags"]
    security-group-delete = ["ecs:DeleteSecurityGroup"]
    security-group-all    = ["ecs:*SecurityGroup*", "ecs:ProcessCommonRequest", "ecs:Describe*"]

    ###########################
    # vpc policy
    ###########################
    vpc-create = ["vpc:CreateVpc", "vpc:ModifyVpcAttribute", "vpc:DescribeVpcAttribute", "vpc:ListTagResources", "vpc:DescribeRouteTables"]
    vpc-update = ["vpc:ModifyVpcAttribute"]
    vpc-read   = ["vpc:DescribeVpcAttribute", "vpc:ListTagResources", "vpc:DescribeRouteTables"]
    vpc-delete = ["vpc:DeleteVpc"]
    vpc-all    = ["vpc:*Vpc*", "vpc:vpc:List*", "vpc:Describe*"]

    ###########################
    # vpc policy
    ###########################
    vswitch-create = ["vpc:CreateVSwitch", "vpc:DescribeVSwitchAttributes", "vpc:DescribeVSwitchAttributes", "vpc:ListTagResources"]
    vswitch-update = ["vpc:ModifyVSwitchAttribute"]
    vswitch-read   = ["vpc:DescribeVSwitchAttributes", "vpc:ListTagResources"]
    vswitch-delete = ["vpc:DeleteVSwitch"]
    vswithch-all   = ["vpc:*VSwitch*", "vpc:List*"]

  }
}
