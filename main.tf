provider "alicloud" {
  version                 = ">=1.64.0"
  profile                 = var.profile != "" ? var.profile : null
  shared_credentials_file = var.shared_credentials_file != "" ? var.shared_credentials_file : null
  region                  = var.region != "" ? var.region : null
  skip_region_validation  = var.skip_region_validation
  configuration_source    = "terraform-alicloud-modules/ram-policy"
}

###########################
# policy with actions
###########################
resource "alicloud_ram_policy" "policy_with_actions" {
  count = var.create ? length(var.policy_with_actions) : 0

  name        = format("terraform-%s", var.policy_with_actions[count.index])
  document    = <<EOF
		{
            "Version": "1",
            "Statement": [
                {
                    "Effect": "Allow",
                    "Action": ${jsonencode(compact(lookup(var.policy_actions, var.policy_with_actions[count.index], [])))},
                    "Resource": "*"
                }
            ]
		}
	  EOF
  description = var.description
  force       = var.force
}


