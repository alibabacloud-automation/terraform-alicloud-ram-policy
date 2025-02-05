locals {
  resource_name_prefix = "tfmod-ram-policy-complete"
}

module "policy" {
  source     = "../../"
  create    = true
  policies  = [
    ###################################################################
    # ram policy with default actions used to to manage ecs Instance  #
    ###################################################################
    {
      name            = "${local.resource_name_prefix}-manage-instance-resource-001"
      defined_actions = var.ecs_defined_actions
      effect          = var.effect
      force           = var.force
    },

    ###############################################################
    # ram policy with custom actions used to to manage OSS bucket #
    ###############################################################
    {
      name      = "${local.resource_name_prefix}-manage-oss-bucket-resource-001"
      actions   = var.oss_bucket_actions
      resources = var.oss_bucket_resources
      effect    = var.effect
      force     = var.force
    },

    #################################################################################
    # ram policy with bosh defined and custom actions used to to manage slb and eip #
    #################################################################################
    {
      name            = "${local.resource_name_prefix}-manage-slb-and-eip-resource-001"
      defined_actions = var.slb_eip_defined_actions
      actions         = var.slb_eip_actions
      resources       = var.slb_eip_resources
    }
  ]
}

module "policy2" {
  source = "../../"
  create = false
}
