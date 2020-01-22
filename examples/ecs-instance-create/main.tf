module "policy-actions" {
  source = "../../"

  policies = [

    {
      # name is the name of the policy, if not specified, the system will generate names prefixed with `terraform_ram_policy_` by default
      # defined_actions is the default resource operation specified by the system. You can refer to the `policies.tf` file.
      name            = "instance-test"
      defined_actions = join(",", ["instance-all", "vpc-all", "vswitch-all", "security-group-all", "security-group-rule-all"])
      effect          = "Allow"
      force           = "true"
    },
    {
      # actions is the action of custom specific resource.
      # resources is the specific object authorized to customize.
      actions         = join(",", ["ecs:xxxx", "vpc:xxxx", "vswitch:xxxe"])
      resources       = join(",", ["xxx:ecs:xxxx", "xxx:vpc:xxxx", "xxx:vswitch:xxxe"])
      defined_actions = join(",", ["instance-create", "vpc-create", "vswitch-create", "security-group-create"])
      effect          = "Deny"
    },
    {
      actions = join(",", ["ecs:xxxx", "vpc:xxxx", "vswitch:xxxe"])
      effect  = "Deny"
      force   = "false"
    },
    {
      name            = "oss-bucket-test"
      defined_actions = join(",", ["oss-bucket-all"])
      effect          = "Allow"
      force           = "true"
      resources       = join(",", ["xxx:ecs:xxxx", "xxx:vpc:xxxx", "xxx:vswitch:xxxe"])
    }
  ]
}