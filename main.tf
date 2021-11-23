locals {
  ###########################
  # defined-actions
  ###########################
  defined_action_list_string = flatten([for _, policy in var.policies : lookup(policy, "defined_actions", "")])
  defined_action_list        = [for _, defined_actions in local.defined_action_list_string : split(",", defined_actions)]
  defined_actions = [
    for _, actions in local.defined_action_list : flatten(
      [
        [for _, action in actions : lookup(var.defined_actions, action, [])]
      ]
    )
  ]

  ###########################
  # custom-actions
  ###########################
  action_list_string = flatten([for _, policy in var.policies : lookup(policy, "actions", "")])
  action_list        = [for _, actions in local.action_list_string : split(",", actions)]
}

resource "alicloud_ram_policy" "policy_with_actions" {
  count = var.create ? length(var.policies) : 0

  name        = lookup(var.policies[count.index], "name", format("terraform-ram-policy-%03d", count.index))
  document    = <<EOF
		{
            "Version": "1",
            "Statement": [
                {
                    "Effect": ${jsonencode(lookup(var.policies[count.index], "effect", "Allow"))},
                    "Action": ${jsonencode(compact(distinct(flatten([local.defined_actions[count.index], local.action_list[count.index]]))))},
                    "Resource": ${jsonencode(split(",", lookup(var.policies[count.index], "resources", "*")))}

                }
            ]
		}
	  EOF
  description = "An Ram Policy created by terraform-alicloud-modules/ram-policy"
  force       = lookup(var.policies[count.index], "force", true)
}
