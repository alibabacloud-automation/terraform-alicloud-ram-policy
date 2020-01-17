module "policy-actions" {
  source = "../../"

  policy_with_actions = ["instance-create", "vpc-create", "vswitch-create", "security-group-create"]
}