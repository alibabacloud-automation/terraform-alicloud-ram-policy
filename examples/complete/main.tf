module "policy" {
  source = "../../"

  policies = [
    ###################################################################
    # ram policy with default actions used to to manage ecs Instance  #
    ###################################################################
    {
      name            = "manage-instance-resource"
      defined_actions = join(",", ["instance-all", "vpc-all", "vswitch-all", "security-group-all", "security-group-rule-all"])
      effect          = "Allow"
      force           = "true"
    },

    ###############################################################
    # ram policy with custom actions used to to manage OSS bucket #
    ###############################################################
    {
      name      = "manage-oss-bucket-resource"
      actions   = join(",", ["oss:PutBucket*", "SetBucket", "GetBucket*", "DeleteBucket*"])
      resources = join(",", ["acs:oss:*:*:*"])
      effect    = "Allow"
      force     = "true"
    },

    #################################################################################
    # ram policy with bosh defined and custom actions used to to manage slb and eip #
    #################################################################################
    {
      name            = "manage-slb-and-eip-resource"
      defined_actions = join(",", ["slb-all", "vpc-all", "vswitch-all"])
      actions         = join(",", ["vpc:AssociateEipAddress", "vpc:UnassociateEipAddress"])
      resources       = join(",", ["acs:vpc:*:*:eip/eip-12345", "acs:slb:*:*:*"])
    }
  ]
}